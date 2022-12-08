import Foundation

class FakeDataManager {
    static let instance = FakeDataManager()
    private init() { }
    
    func getUser() -> User {
        User(login: "login", avatar_url: "", html_url: "", repos_url: "", name: "Uliana", location: "Belgorod", bio: "ios Developer", public_repos: 6, followers: 120, following: 2, created_at: "22.11.2001")
    }
}
