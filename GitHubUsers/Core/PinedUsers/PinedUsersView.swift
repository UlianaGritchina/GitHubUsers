import SwiftUI

struct PinnedUsersView: View {
    @StateObject var vm = PinedUsersViewModel()
    var body: some View {
        NavigationView {
            VStack {
                UsersListView(users: vm.users)
            }
            .navigationTitle("Pined users")
        }
        .onAppear {
            vm.getUsers()
        }
    }
}

struct PinedUsersView_Previews: PreviewProvider {
    static var previews: some View {
        PinnedUsersView()
    }
}
