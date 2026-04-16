import SwiftUI

struct UsersListView: View {
    @StateObject private var viewModel = UsersViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.filteredUsers, id: \.id) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Users")
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search by name or email"
            )
            .task {
                viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    UsersListView()
}
