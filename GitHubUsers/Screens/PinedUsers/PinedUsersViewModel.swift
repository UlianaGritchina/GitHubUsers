import Foundation

class PinedUsersViewModel: ObservableObject {
    @Published var users: [User] = [FakeDataManager.instance.getUser()]
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        users = UserDefaultsDataManager.instance.getPinnedUsers()
    }
    
}
