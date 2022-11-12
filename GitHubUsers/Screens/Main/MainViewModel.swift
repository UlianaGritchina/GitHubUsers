
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var user: User = User(
        login: "",
        avatar_url: "",
        html_url: "",
        repos_url: "",
        name: "",
        location: "",
        bio: "",
        public_repos: "",
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
                self.user = try await NetworkManager.shared.fetchUserBy(userName: "UlianaGritchina")
            } catch {
                print(error)
            }
        }
    }
}
