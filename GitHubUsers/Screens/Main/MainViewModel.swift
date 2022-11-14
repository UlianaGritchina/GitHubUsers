
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
    @Published var avatarImage: Image = Image(systemName: "person")
    @Published var avatarImageData: Data = Data()
    @Published var isShowingUserInfoView = false
    @Published var networkState: NetworkState = .none
    
    func showUserInfo() {
        isShowingUserInfoView.toggle()
    }
    
    func findUser() {
        networkState = .loading
        NetworkManager.shared.fetchUserBy(userName: username) { user, networkState in
            guard let user = user else { return }
            DispatchQueue.main.async {
                self.user = user
                self.fetchUserAvatar()
            }
        }
    }
    
    private func fetchUserAvatar() {
        NetworkManager.shared.fetchUserAvatar(stringUrl: user.avatar_url ?? "") { image, error in
            if let image = image {
                DispatchQueue.main.async {
                    self.avatarImage = Image(uiImage: image)
                    self.avatarImageData = image.pngData() ?? Data()
                    self.networkState = .loaded
                }
            }
        }
    }
    
}
