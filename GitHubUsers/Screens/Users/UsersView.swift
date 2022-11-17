import SwiftUI

struct UsersView: View {
    @StateObject var vm = UsersViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if vm.users.isEmpty {
                    ProgressView()
                } else {
                    usersList
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

extension UsersView {
    private var usersList: some View {
        ScrollView {
            ForEach(vm.users, id: \.self) { user in
                UserRowView(user: user).padding(.bottom)
            }
            .padding()
            .animation(.default, value: vm.users)
        }
    }
}
