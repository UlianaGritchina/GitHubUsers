
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
                    PineButton(action: {})
                    Spacer()
                    CloseButton(action: {presentationMode.wrappedValue.dismiss()})
                }
                .padding([.horizontal, .top])
                
                ScrollView() {
                    UserBaseInfoCardView(user: vm.user).padding(.top, height / 3.2)
                    reposView
                    Spacer()
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

extension UserInfoView {
    
    private var avatarImageView: some View {
        Image(uiImage: UIImage(data: vm.user.avatarImageData ?? Data()) ?? vm.defoultImage)
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
    
    private var reposView: some View {
        VStack {
            if vm.loadRepos == .loaded {
                HStack {
                    Text("Public repos \(vm.repos.count)")
                        .font(.title2)
                        .bold()
                    Spacer()
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.headline)
                        Text("\(vm.starsCount)")
                    }
                    .font(.headline)
                }
                .padding(.horizontal)
                .offset(y: 20)
                reposScroll
            } else {
                ProgressView()
            }
        }
    }
    
    private var reposScroll: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(vm.repos, id: \.self) { repo in
                    RepoRowView(repo: repo).padding()
                        .onTapGesture { vm.showRepoInfo(repo) }
                }
            }
        }
    }
    
}
