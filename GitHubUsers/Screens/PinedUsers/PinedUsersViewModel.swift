import Foundation

class PinedUsersViewModel: ObservableObject {
    @Published var users: [User] = [FakeDataManager.instance.getUser()]
}
