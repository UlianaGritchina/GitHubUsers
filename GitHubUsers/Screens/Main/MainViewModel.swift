
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var username = ""
    @Published var isShowingUserInfoView = false
    
    func showUserInfo() {
        isShowingUserInfoView.toggle()
    }
    
    func findUser() {
        
    }
}
