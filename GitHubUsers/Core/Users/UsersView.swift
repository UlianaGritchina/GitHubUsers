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
                    Text("🛑 Error 🛑").font(.headline)
                }
                UsersListView(users: vm.users)
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

