import SwiftUI

struct UsersView: View {
    @StateObject var vm = UsersViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if vm.users.isEmpty {
                    ProgressView()
                } else {
                    UsersListView(users: vm.users)
                }
            }
            .navigationTitle("Users")
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}

