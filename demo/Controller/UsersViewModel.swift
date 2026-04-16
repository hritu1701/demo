import Foundation
import Combine

@MainActor
final class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var searchText = ""

    private let userService: UserService

    @MainActor
    init(userService: UserService? = nil) {
        if let userService {
            self.userService = userService
        } else {
            // create the default service on the main actor to satisfy actor isolation
            self.userService = UserService()
        }
    }

    var filteredUsers: [User] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return users }
        return users.filter { user in
            user.name.lowercased().contains(query) || user.email.lowercased().contains(query)
        }
    }

    func fetchUsers() {
        userService.fetchUsers { [weak self] result in
            guard let self else { return }
            Task { @MainActor in
                switch result {
                case .success(let users):
                    self.users = users
                case .failure:
                    self.users = []
                }
            }
        }
    }
}
