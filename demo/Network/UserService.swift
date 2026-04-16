import Foundation

enum UserServiceError: Error {
    case invalidResponse
    case noCachedData
}

final class UserService {
    private let session: URLSession
    private let cacheKey = "cached_users"
    private let endpoint = URL(string: "https://jsonplaceholder.typicode.com/users")!

    nonisolated init(session: URLSession = .shared) {
        self.session = session
    }

    // Closure-based API handling for request completion.
    nonisolated func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let task = session.dataTask(with: endpoint) { [weak self] data, response, error in
            guard let self else { return }

            if let error {
                self.loadCachedUsers(completion: completion, fallbackError: error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode), let data else {
                self.loadCachedUsers(completion: completion, fallbackError: UserServiceError.invalidResponse)
                return
            }

            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self.saveUsersToCache(users)
                completion(.success(users))
            } catch {
                self.loadCachedUsers(completion: completion, fallbackError: error)
            }
        }
        task.resume()
    }

    private nonisolated func saveUsersToCache(_ users: [User]) {
        do {
            let data = try JSONEncoder().encode(users)
            UserDefaults.standard.set(data, forKey: cacheKey)
        } catch {
            // Ignore cache write failures and keep API result flow intact.
        }
    }

    private nonisolated func loadCachedUsers(completion: @escaping (Result<[User], Error>) -> Void, fallbackError: Error) {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else {
            completion(.failure(fallbackError))
            return
        }

        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            completion(.success(users))
        } catch {
            completion(.failure(UserServiceError.noCachedData))
        }
    }
}
