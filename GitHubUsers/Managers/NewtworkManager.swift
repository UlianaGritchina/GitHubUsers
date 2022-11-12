import Foundation

enum NetworkState: Error {
    case badURL
    case noData
    case loading
}

class NetworkManager {
    
    static let shared  = NetworkManager()
    private init () { }
    private let baseUsersUrl = "https://api.github.com/users/"
    
    func fetchUserBy(userName: String) async throws -> User {
        guard let url = URL(string: baseUsersUrl + userName) else {
            throw NetworkState.badURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let user = try? JSONDecoder().decode(User.self, from: data) else {
            throw NetworkState.noData
        }
        
        return user
    }
    
}
