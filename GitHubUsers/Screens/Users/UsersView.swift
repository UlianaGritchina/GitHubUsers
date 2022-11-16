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
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [User].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (returnedUsers) in
                self?.getUserInfo(users: returnedUsers)
            })
            .store(in: &cancellables)
    }
    
    func getUserInfo(users: [User]) {
        for user in users {
            NetworkManager.shared.fetchUserBy(userName: user.login ?? "") { user, networkState in
                guard let user = user else { return }
                DispatchQueue.main.async {
                    self.users.append(user)
                }
            }
        }
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

struct UsersView: View {
    @StateObject var vm = UsersViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(vm.users, id: \.self) { user in
                    UserRowView(user: user, avatarImageData: Data())
                        .padding(.bottom)
                }
                .padding()
            }
            .navigationTitle("Users")
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
