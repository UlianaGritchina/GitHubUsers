import SwiftUI
import Combine

class UsersViewModel: ObservableObject {
    
    @Published var users: [User] = []
    private let networkManager = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        guard let url = URL(string: "https://api.github.com/users") else { return }
        NetworkManager.shared.downloadUsersBy(url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: print("fin")
                case .failure(_): print("fail")
                }
            } receiveValue: { [weak self] users in
                guard let users = users else { return }
                self?.getUserInfo(users: users)
            }
            .store(in: &cancellables)
    }
    
    func getUserInfo(users: [User]) {
        for user in users {
            guard let url = URL(string: networkManager.baseUsersUrl + (user.login ?? "")) else { return }
            networkManager.downloadUserInfo(url: url)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    
                } receiveValue: { [weak self] user in
                    guard let user = user else { return }
                    self?.setUserAvatarImageData(user)
                }
                .store(in: &self.cancellables)
        }
    }
    
    func setUserAvatarImageData(_ user: User) {
        guard let avatarUrl = URL(string: user.avatar_url ?? "") else { return }
        networkManager.downloadUserAvatarImageData(url: avatarUrl)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] imageData in
                guard let data = imageData else { return }
                var newUser = user
                newUser.avatarImageData = data
                self?.users.append(newUser)
            }
            .store(in: &self.cancellables)
    }
    
}

