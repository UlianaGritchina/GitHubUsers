import SwiftUI

struct StarterView: View {
    var body: some View {
        TabView {
            UsersView()
                .tabItem {
                    Label("Users", systemImage: "list.dash")
                }
            
            FindUserView()
                .tabItem {
                    Label("Find user", systemImage: "magnifyingglass")
                }
            
            PinnedUsersView()
                .tabItem {
                    Label("Pinned users", systemImage: "pin")
                }
        }
    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
    }
}
