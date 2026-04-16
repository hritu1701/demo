# Demo iOS Assignment (SwiftUI)

This project implements the requested user listing app using native Apple frameworks.

## Note on UI Framework

The original requirement mentioned `ViewController` (typically UIKit), but this implementation uses **SwiftUI**  with native components (`NavigationStack`, `List`, `NavigationLink`, `.searchable`).

- UIKit was intentionally replaced with SwiftUI.

## API Integration + Caching

- Endpoint: `https://jsonplaceholder.typicode.com/users`
- Users are fetched and displayed in the main list.
- Successful responses are cached locally using `UserDefaults`.
- If API fails, cached data is loaded and shown.

Implementation: `demo/Network/UserService.swift`

## Search Functionality

- Search bar appears on top.
- Real-time filtering by:
  - `name`
  - `email`

Implementation:
- UI: `demo/Views/UsersListView.swift`
- Filter logic: `demo/Controller/UsersViewModel.swift`

## Detail Screen + Data Passing

- On user row tap:
  - navigates to detail screen
  - passes full `User` object (not only ID)
- Detail screen shows all fields including nested:
  - address
  - geo
  - company

Implementation:
- Navigation: `demo/Views/UsersListView.swift`
- Detail UI: `demo/Views/UserDetailView.swift`

## Async + Thread Handling

- API runs asynchronously using `URLSession.dataTask` (background execution).
- UI state updates are dispatched on main thread using `DispatchQueue.main.async`.

Implementation:
- Network: `demo/Network/UserService.swift`
- Main-thread UI updates: `demo/Controller/UsersViewModel.swift`

## Memory Leak Prevention

- Uses closure-based API handling.
- Uses `[weak self]` in asynchronous closures to avoid retain cycles.

Implementation:
- `demo/Network/UserService.swift`
- `demo/Controller/UsersViewModel.swift`

## Architecture (MVCN-style folders)

- **Models**: `demo/Models/User.swift`
- **Views**: `demo/Views/UsersListView.swift`, `demo/Views/UserDetailView.swift`
- **Controller**: `demo/Controller/UsersViewModel.swift`
- **Network**: `demo/Network/UserService.swift`

## App Entry

- `demo/demoApp.swift` launches `UsersListView`.
