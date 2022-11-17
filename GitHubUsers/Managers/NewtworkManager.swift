import SwiftUI
import Combine

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
    let baseUsersUrl = "https://api.github.com/users/"
    
    func downloadUserAvatarImageData(url: URL) -> AnyPublisher<Data?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func downloadUsersCombine(url: URL) -> AnyPublisher<[User]?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(checkUsersResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func downloadUserInfo(url: URL) -> AnyPublisher<User?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(checkUserResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func fetchUserBy(userName: String, completion:  @escaping(_ user: User?, _ networkState: NetworkState) -> ()) {
        guard let url = URL(string: baseUsersUrl + userName) else {
            completion(nil, .badURL)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(nil, .error)
                return
            }
            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                completion(nil, .noData)
                return
            }
            completion(user, .loaded)
        }
        .resume()
    }
    
    func fetchRepos(stringUrl: String, completion:  @escaping(_ repos: [Repository]?) -> ()) {
        guard let url = URL(string: stringUrl) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(nil)
                return
            }
            guard let repos = try? JSONDecoder().decode([Repository].self, from: data) else {
                completion(nil)
                return
            }
            completion(repos)
        }
        .resume()
    }

    func handleResponse(data: Data?, response: URLResponse?) -> Data? {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                return nil
            }
        return data
    }
    
    func checkUsersResponse(data: Data?, response: URLResponse?) -> [User] {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            print("data or code")
                return []
            }
        guard  let users = try? JSONDecoder().decode([User].self, from: data) else {
            print("no decode")
            return []
        }
        return users
    }
    
    func checkUserResponse(data: Data?, response: URLResponse?) -> User? {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            print("data or code")
                return nil
            }
        guard  let user = try? JSONDecoder().decode(User.self, from: data) else {
            print("no decode")
            return nil
        }
        return user
    }
    
    
    
    /*
     
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
     
    */ // DOWNLOADING IMAGE WITH ESCAPING
}
