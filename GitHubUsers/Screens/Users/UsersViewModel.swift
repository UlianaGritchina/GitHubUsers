import SwiftUI
import Combine

class UsersViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var networkState: NetworkState = .none
    private let networkManager = GitHubApiManager.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        networkState = .loading
        guard let url = URL(string: "https://api.github.com/users") else {
            networkState = .error
            return
        }
        GitHubApiManager.shared.downloadUsersBy(url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: print("fin")
                case .failure(_): print("fail")
                }
            } receiveValue: { [weak self] users in
                guard let users = users else {
                    self?.networkState = .error
                    return
                }
                self?.getUserInfo(users: users)
            }
            .store(in: &cancellables)
    }
    
    func getUserInfo(users: [User]) {
        for user in users {
            guard let url = URL(string: networkManager.baseUsersUrl + (user.login ?? "")) else {
                networkState = .error
                return
            }
            networkManager.downloadUserInfo(url: url)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    
                } receiveValue: { [weak self] user in
                    guard let user = user else {
                        self?.networkState = .error
                        return
                    }
                    self?.setUserAvatarImageData(user)
                }
                .store(in: &self.cancellables)
        }
        withAnimation {
            if users.count != 0 {
                networkState = .loaded
            } else {
                networkState = .error
            }
        }
    }
    
    func setUserAvatarImageData(_ user: User) {
        guard let avatarUrl = URL(string: user.avatar_url ?? "") else {
            networkState = .error
            return
        }
        networkManager.downloadUserAvatarImageData(url: avatarUrl)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] imageData in
                guard let data = imageData else {
                    self?.networkState = .error
                    return
                }
                var newUser = user
                newUser.avatarImageData = data
                self?.users.append(newUser)
            }
            .store(in: &self.cancellables)
    }
    
}

