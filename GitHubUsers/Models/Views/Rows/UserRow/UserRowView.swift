import SwiftUI

struct UserRowView: View {
    let user: User
    @State private var isShowingUserInfoView = false
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        userPreviewCard
            .sheet(isPresented: $isShowingUserInfoView, content: {
                UserInfoView(vm: UserInfoViewModel(user: user ))
            })
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: FakeDataManager.instance.getUser())
    }
}


extension UserRowView {
    
    private var userPreviewCard: some View {
        Button(action: { isShowingUserInfoView.toggle() }) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: width - 40, height: width / 3)
                .foregroundColor(Color("card"))
                .shadow(color: Color("shadow"), radius: 5)
                .blur(radius: 0.5)
                .overlay { userPrewiewContent.padding() }
        }
    }
    
    private var userPrewiewContent: some View {
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
            .foregroundColor(Color("text"))
            Spacer()
        }
    }
    
}
