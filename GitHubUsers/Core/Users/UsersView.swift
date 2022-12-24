import SwiftUI

struct UsersView: View {
    @StateObject var vm = UsersViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if vm.networkState == .loading {
                    ProgressView()
                }
                if vm.networkState == .error {
                    Text("Error")
                }
                UsersListView(users: vm.users)
                    .opacity(vm.networkState == .loaded ? 1 : 0)
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

