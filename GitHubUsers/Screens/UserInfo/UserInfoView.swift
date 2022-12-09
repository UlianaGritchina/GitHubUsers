
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
            VStack {
                HStack {
                    PineButton(isTapeed: $vm.isPinned, action: vm.pinUser)
                    Spacer()
                    CloseButton(action: {presentationMode.wrappedValue.dismiss()})
                }
                .padding([.horizontal, .top])
                
                ScrollView() {
                    UserBaseInfoCardView(user: vm.user).padding(.top, height / 3.2)
                    
                    if vm.loadRepos == .loading {
                        ProgressView()
                    } else {
                        ReposView(repos: vm.repos, stars: vm.starsCount)
                    }
                }
            }
            RepoInfoView(repo: vm.selectedRepo, isShowingRepoInfo: $vm.isShowingRepoInfo)
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
        Image(uiImage: UIImage(data: vm.user.avatarImageData ?? Data()) ?? vm.defaultImage)
            .resizable()
            .scaledToFill()
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Text(vm.user.name ?? vm.user.login ?? "")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .background(.ultraThinMaterial)
                }
            }
            .frame(width: width, height: height / 4)
    }
    
}

