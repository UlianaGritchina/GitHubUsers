import SwiftUI
import Combine

class FindUserViewModel: ObservableObject {
    
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
    var cancellables = Set<AnyCancellable>()
    
    func showUserInfo() {
        isShowingUserInfoView.toggle()
    }
    
    func findUser() {
        networkState = .loading
        NetworkManager.shared.fetchUserBy(userName: username) { user, networkState in
            guard let user = user else { return }
            DispatchQueue.main.async {
                self.user = user
                self.getUserAvatarImageData()

            }
        }
    }
    
    func getUserAvatarImageData() {
        guard let url = URL(string: user.avatar_url ?? "") else { return }
        NetworkManager.shared.downloadUserAvatarImageData(url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: print("fin")
                case .failure(_): print("fail")
                }
            } receiveValue: { [weak self] imageData in
                guard let data = imageData else { return }
                self?.avatarImageData = data
                self?.networkState = .loaded
            }
            .store(in: &cancellables)
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

