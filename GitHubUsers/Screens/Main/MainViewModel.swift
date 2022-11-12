
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var user: User = User(
        login: "",
        avatar_url: "",
        html_url: "",
        repos_url: "",
        name: "NAME",
        location: "location",
        bio: "bio",
        public_repos: 0,
        followers: 0,
        following: 0,
        created_at: ""
    )
    @Published var username = ""
    @Published var isShowingUserInfoView = false
    
    func showUserInfo() {
        isShowingUserInfoView.toggle()
    }
    
    func findUser() {
        Task {
            do {
                self.user = try await NetworkManager.shared.fetchUserBy(userName: username)
            } catch {
                print(error)
            }
        }
    }
}
