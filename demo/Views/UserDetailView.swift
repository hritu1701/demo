import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        List {
            Section("Basic") {
                detailRow("ID", "\(user.id)")
                detailRow("Name", user.name)
                detailRow("Username", user.username)
                detailRow("Email", user.email)
                detailRow("Phone", user.phone)
                detailRow("Website", user.website)
            }

            Section("Address") {
                detailRow("Street", user.address.street)
                detailRow("Suite", user.address.suite)
                detailRow("City", user.address.city)
                detailRow("Zipcode", user.address.zipcode)
                detailRow("Geo Lat", user.address.geo.lat)
                detailRow("Geo Lng", user.address.geo.lng)
            }

            Section("Company") {
                detailRow("Name", user.company.name)
                detailRow("Catch Phrase", user.company.catchPhrase)
                detailRow("Business", user.company.bs)
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func detailRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    UserDetailView(
        user: User(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "Sincere@april.biz",
            address: Address(
                street: "Kulas Light",
                suite: "Apt. 556",
                city: "Gwenborough",
                zipcode: "92998-3874",
                geo: Geo(lat: "-37.3159", lng: "81.1496")
            ),
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: Company(
                name: "Romaguera-Crona",
                catchPhrase: "Multi-layered client-server neural-net",
                bs: "harness real-time e-markets"
            )
        )
    )
}
