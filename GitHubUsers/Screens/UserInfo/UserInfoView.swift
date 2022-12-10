import SwiftUI

struct UserInfoView: View {
    @ObservedObject var vm: UserInfoViewModel
    @Environment(\.presentationMode) var presentationMode
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        ZStack {
            VStack {
                avatarImageView
                Spacer()
            }
            ScrollView() {
                UserBaseInfoCardView(user: vm.user)
                    .padding(.top, height / 2.6)
                    .padding(.horizontal)
                if vm.loadRepos == .loading {
                    ProgressView()
                } else {
                    ReposView(
                        avatarImageData: vm.user.avatarImageData ?? Data(),
                        repos: vm.repos,
                        stars: vm.starsCount
                    )
                }
            }
            .overlay(buttonsView, alignment: .top)
        }
        .onAppear { vm.getRepos() }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(
            vm: UserInfoViewModel(user: FakeDataManager.instance.getUser())
        )
    }
}


//MARK: - VIEW COMPONENTS

extension UserInfoView {
    
    private var avatarImageView: some View {
        vm.avatarImage
            .resizable()
            .scaledToFill()
            .overlay(usernameView, alignment: .bottom)
            .frame(width: width, height: height / 4)
    }
    
    private var usernameView: some View {
        Text(vm.user.name ?? vm.user.login ?? "")
            .bold()
            .font(.largeTitle)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
    }
    
    private var buttonsView: some View {
        HStack {
            PineButton(isTapeed: $vm.isPinned, action: vm.pinUser)
            Spacer()
            CloseButton(action: {presentationMode.wrappedValue.dismiss()})
        }
        .padding()
    }
    
}

