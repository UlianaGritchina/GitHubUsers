
import SwiftUI

class UserInfoViewModel: ObservableObject {
    
    var user: User = User(
        login: "",
        avatar_url: "",
        html_url: "",
        repos_url: "",
        name: "",
        location: "",
        bio: "",
        public_repos: 0,
        followers: 0,
        following: 0,
        created_at: ""
    )
    
    var userAvatarImageData = Data()
    let defoultImage: UIImage = UIImage(named: "Octocat")!
    
    @Published var repos: [Repository] = []
    @Published var loadRepos: NetworkState = .none
    init(user: User, avatarImageData: Data) {
        self.user = user
        self.userAvatarImageData = avatarImageData
    }
    
    func getRepos() {
        loadRepos = .loading
        Task {
            do {
                self.repos = try await NetworkManager.shared.fetchRepos(stringUrl: user.repos_url ?? "")
                self.sortReposByStars()
                loadRepos = .loaded
            } catch {
                loadRepos = .error
            }
        }
    }
    
    func sortReposByStars() {
       repos = repos.sorted(by: { $0.stargazers_count! > $1.stargazers_count! })
    }
    
}
