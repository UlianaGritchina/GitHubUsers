
import SwiftUI

class UserInfoViewModel {
    
    var user: User = User(
        login: "",
        avatar_url: "",
        html_url: "",
        repos_url: "",
        name: "",
        location: "",
        bio: "",
        public_repos: 0,
        followers: 0,
        following: 0,
        created_at: ""
    )
    
    var userAvatarImageData = Data()
    let defoultImage: UIImage = UIImage(named: "Octocat")!
    
    init(user: User, avatarImageData: Data) {
        self.user = user
        self.userAvatarImageData = avatarImageData
    }
}
