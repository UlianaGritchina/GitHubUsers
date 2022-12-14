import Combine
import SwiftUI

class FindUserViewModel: ObservableObject {
    
    @Published var user: User = FakeDataManager.instance.getUser()
    @Published var avatarImage: Image = Image(systemName: "person")
    @Published var networkState: NetworkState = .none
    @Published var avatarImageData: Data = Data()
    @Published var isShowingUserInfoView = false
    @Published var username = ""
    
    var cancellables = Set<AnyCancellable>()
    private let networkManager = GitHubApiManager.shared
    
    func showUserInfo() {
        isShowingUserInfoView.toggle()
    }
    
    func findUser() {
        networkState = .loading
        guard let url = URL(string: networkManager.baseUsersUrl + username) else {
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
                self?.user = user
                self?.getUserAvatarImageData()
            }
            .store(in: &cancellables)
    }
    
    func getUserAvatarImageData() {
        guard let url = URL(string: user.avatar_url ?? "") else {
            networkState = .error
            return
        }
        networkManager.downloadUserAvatarImageData(url: url)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] imageData in
                guard let data = imageData else {
                    self?.networkState = .error
                    return
                }
                var newUser = self?.user
                newUser?.avatarImageData = data
                newUser?.avatarImageData = data
                self?.user = newUser!
                withAnimation {
                    self?.networkState = .loaded
                }
            }
            .store(in: &cancellables)
    }
    
}

