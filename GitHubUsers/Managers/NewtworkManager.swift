import SwiftUI

enum NetworkState: Error {
    case badURL
    case noData
    case loading
    case loaded
    case error
    case none
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
    
    func fetchUserAvatar(stringUrl: String, completion:  @escaping(_ image: UIImage?, _ error: Error?) -> () ) {
        guard let url = URL(string: stringUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(nil, error)
                return
            }
            completion(image, nil )
        }
        .resume() 
    }
    
}
