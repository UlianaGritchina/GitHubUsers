import Foundation

class UserDefaultsDataManager {
    
    static let instance = UserDefaultsDataManager()
    private init () { }
    
    func savePinedUsers(_ users: [User]) {
        if let encodedData = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encodedData, forKey: "pinned")
        }
    }
    
    func getPinnedUsers() -> [User] {
        guard
            let data = UserDefaults.standard.data(forKey: "pinned"),
            let savedUsers = try? JSONDecoder().decode([User].self, from: data)
        else { return [] }
        return savedUsers
    }
    
}
