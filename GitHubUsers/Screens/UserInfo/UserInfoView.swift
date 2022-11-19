
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
                    Spacer()
                    closeButton
                }
                .padding([.horizontal, .top])
                
                ScrollView() {
                    userInfoView
                        .padding(.top, height / 3.2)
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
            vm: UserInfoViewModel(
                user: User(
                    login: "login",
                    avatar_url: "",
                    html_url: "",
                    repos_url: "https://api.github.com/users/UlianaGritchina/repos",
                    name: "name",
                    location: "location",
                    bio: "bio",
                    public_repos: 5,
                    followers: 5,
                    following: 5,
                    created_at: "",
                    avatarImageData: Data()
                )
            )
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
    
    private var userInfoView: some View {
        HStack {
            VStack(alignment: .leading) {
                if let bio = vm.user.bio {
                    Text(bio).bold()
                }
                if let location = vm.user.location {
                    Text(location)
                }
                if let followers = vm.user.followers {
                    Text("Followers: \(followers)")
                }
                if let following = vm.user.following {
                    Text("Following: \(following)")
                }
            }
            .font(.system(size: height / 40))
            Spacer()
        }
        .padding()
        .frame(width: width - 20)
        .background(
            Color("card")
                .cornerRadius(10)
                .shadow(color: Color("shadow"), radius: 5)
        )
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
    
    private var closeButton: some View {
        Button(action: {presentationMode.wrappedValue.dismiss()}) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 35, height:  35)
                .foregroundColor(.black.opacity(0.5))
                .overlay {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
        }
    }
    
}
