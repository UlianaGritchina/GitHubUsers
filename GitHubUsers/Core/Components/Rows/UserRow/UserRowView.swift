import SwiftUI

struct UserRowView: View {
    let user: User
    @State private var isShowingUserInfoView = false
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        userPreviewCard
            .fullScreenCover(isPresented: $isShowingUserInfoView) {
                UserInfoView(vm: UserInfoViewModel(user: user ))
            }
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: FakeDataManager.instance.getUser())
    }
}


//MARK: - VIEW COMPONENTS

extension UserRowView {
    
    private var userPreviewCard: some View {
        Button(action: { isShowingUserInfoView.toggle() }) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: width - 40, height: width / 3)
                .foregroundColor(.card)
                .shadow(color: .shadow, radius: 5)
                .blur(radius: 0.5)
                .overlay { userPreviewContent.padding() }
        }
    }
    
    private var userPreviewContent: some View {
        HStack {
            Image(uiImage: UIImage(data: user.avatarImageData ?? Data()) ?? UIImage(named: "Octocat")!)
                .resizable()
                .frame(width: width / 4, height: width / 4)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 10) {
                Text(user.login ?? "")
                    .font(.system(size: height / 40))
                    .bold()
                Text(user.bio ?? "")
                Text(user.location ?? "")
            }
            .foregroundColor(.text)
            Spacer()
        }
    }
    
}
