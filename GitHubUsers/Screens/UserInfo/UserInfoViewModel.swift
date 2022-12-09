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
    var isPinnedUser: Bool {
        user.isPinned ?? false
    }
    @Published var loadRepos: NetworkState = .none
    @Published var starsCount = 0
    @Published var isShowingRepoInfo = false
    @Published var isPinned = false
    let defaultImage: UIImage = UIImage(named: "Octocat")!
    
    
    private var pinnedUsers = UserDefaultsDataManager.instance.getPinnedUsers()
    
    init(user: User) {
        self.user = user
        isPinned = user.isPinned ?? false
    }
    
    func pinUser() {
        if isPinned {
            isPinned = false
            deleteUser(user)
        } else {
            user.isPinned = true
            isPinned = true
            pinnedUsers.append(user)
        }
        saveUsers()
    }
    
    func deleteUser(_ user: User) {
        pinnedUsers = pinnedUsers.filter { $0 != user }
        saveUsers()
    }
    
    func saveUsers() {
        UserDefaultsDataManager.instance.savePinedUsers(pinnedUsers)
    }
    
    func getRepos() {
        loadRepos = .loading
        GitHubApiManager.shared.fetchRepos(stringUrl: user.repos_url ?? "") { repos in
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

