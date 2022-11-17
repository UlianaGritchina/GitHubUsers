import SwiftUI
import Combine

class UsersViewModel: ObservableObject {
    
    @Published var users: [User] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        guard let url = URL(string: "https://api.github.com/users") else { return }
        NetworkManager.shared.downloadUsersCombine(url: url)
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
            NetworkManager.shared.fetchUserBy(userName: user.login ?? "") { user, networkState in
                guard let user = user else { return }
                DispatchQueue.main.async {
                    self.setUserAvatarImageData(user)
                }
            }
        }
    }
    
    func setUserAvatarImageData(_ user: User) {
        guard let avatarUrl = URL(string: user.avatar_url ?? "") else { return }
        NetworkManager.shared.downloadUserAvatarImageData(url: avatarUrl)
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
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

