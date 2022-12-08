import SwiftUI

struct PinedUsersView: View {
    @StateObject var vm = PinedUsersViewModel()
    var body: some View {
        NavigationView {
            VStack {
                UsersListView(users: vm.users)
            }
            .navigationTitle("Pined users")
        }
    }
}

struct PinedUsersView_Previews: PreviewProvider {
    static var previews: some View {
        PinedUsersView()
    }
}
