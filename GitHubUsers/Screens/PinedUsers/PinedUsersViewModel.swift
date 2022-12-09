import Foundation

class PinedUsersViewModel: ObservableObject {
    @Published var users: [User] = [FakeDataManager.instance.getUser()]
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        users = UserDefaultsDataManager.instance.getPinnedUsers()
    }
    
    func deleteUser(_ user: User) {
        users = users.filter { $0 != user }
        saveUsers()
        getUsers()
    }
    
    func saveUsers() {
        UserDefaultsDataManager.instance.savePinedUsers(users)
        getUsers()
    }
    
}
