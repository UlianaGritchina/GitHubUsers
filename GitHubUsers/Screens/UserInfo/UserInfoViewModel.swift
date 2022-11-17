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
        created_at: "",
        avatarImageData: Data()
    )
    
    let defoultImage: UIImage = UIImage(named: "Octocat")!
    
    @Published var repos: [Repository] = []
    @Published var loadRepos: NetworkState = .none
    @Published var starsCount = 0
    
    init(user: User) {
        self.user = user
    }
    
    func getRepos() {
        loadRepos = .loading
        NetworkManager.shared.fetchRepos(stringUrl: user.repos_url ?? "") { repos in
            guard let repos = repos else { return }
            DispatchQueue.main.async {
                self.repos = repos
                self.sortReposByStars()
                self.starsCount = self.getStarsCount()
                self.loadRepos = .loaded
            }
        }
    }
    
    private func sortReposByStars() {
        repos = repos.sorted(by: { $0.stargazers_count! > $1.stargazers_count! })
    }
    
    private func getStarsCount() -> Int {
        var count = 0
        for repo in repos {
            count += repo.stargazers_count ?? 0
        }
        return count
    }
    
}

