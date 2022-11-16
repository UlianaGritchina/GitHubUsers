
import SwiftUI

@main
struct GitHubUsersApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                UsersView()
                    .tabItem {
                        Label("Users", systemImage: "list.dash")
                    }
                
                FindUserView()
                    .tabItem {
                        Label("Find user", systemImage: "magnifyingglass")
                    }
            }
        }
    }
}
