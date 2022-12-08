import SwiftUI

class UserInfoViewModel: ObservableObject {
    
    var user: User = FakeDataManager.instance.getUser()
    
    @Published var  selectedRepo =  Repository(
        name: "name",
        description: "des",
        html_url: "",
        stargazers_count: 4,
        language: "swift",
        visibility: "public"
    )
    
    
    @Published var repos: [Repository] = []
    @Published var loadRepos: NetworkState = .none
    @Published var starsCount = 0
    @Published var isShowingRepoInfo = false
    
    let defoultImage: UIImage = UIImage(named: "Octocat")!
    
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
    
    func showRepoInfo(_ repo: Repository) {
        selectedRepo = repo
        withAnimation(.spring()) {
            isShowingRepoInfo.toggle()
        }
    }
    
}

