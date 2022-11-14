import SwiftUI

struct UserRowView: View {
    let user: User
    let avatarImageData: Data
    @State private var isShowingUserInfoView = false
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        userPreviewCard
            .sheet(isPresented: $isShowingUserInfoView, content: {
                UserInfoView(
                    vm: UserInfoViewModel(
                        user: user,
                        avatarImageData: avatarImageData
                    )
                )
                
            })
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(
            user: User(
                login: "",
                avatar_url: "",
                html_url: "",
                repos_url: "",
                name: "name",
                location: "loc",
                bio: "bio",
                public_repos: 4,
                followers: 6,
                following: 3,
                created_at: ""),
            avatarImageData: Data()
        )
    }
}


extension UserRowView {
    
    private var userPreviewCard: some View {
        Button(action: {isShowingUserInfoView.toggle() }) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: width - 80, height: width / 3)
                .foregroundColor(Color("card"))
                .shadow(color: Color("shadow"), radius: 5)
                .blur(radius: 0.5)
                .overlay { userPrewiewContent.padding() }
        }
    }
    
    private var userPrewiewContent: some View {
        HStack {
            Image(uiImage: UIImage(data: avatarImageData) ?? UIImage(named: "Octocat")!)
                .resizable()
                .frame(width: width / 4, height: width / 4)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 10) {
                Text(user.name ?? "noname").font(.headline)
                Text(user.bio ?? "nobio")
                Text(user.location ?? "nolocation")
            }
            .foregroundColor(Color("text"))
            Spacer()
        }
    }
    
}
