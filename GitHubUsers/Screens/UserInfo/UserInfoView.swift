
import SwiftUI

struct UserInfoView: View {
    let vm: UserInfoViewModel!
    @Environment(\.presentationMode) var presentationMode
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    avatarImageView
                    Spacer()
                }
                ScrollView() {
                    userInfoView.padding(.top, height / 2.6)
                    reposView
                    Spacer()
                }
            }
        }
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
                    repos_url: "",
                    name: "name",
                    location: "location",
                    bio: "bio",
                    public_repos: 5,
                    followers: 5,
                    following: 5,
                    created_at: ""
                ),
                avatarImageData: Data()
            )
        )
    }
}

extension UserInfoView {
    
    private var avatarImageView: some View {
        Image(uiImage: UIImage(data: vm.userAvatarImageData) ?? vm.defoultImage)
            .resizable()
            .scaledToFill()
            .overlay {
                VStack {
                    closeButton
                    Spacer()
                    HStack {
                        Text(vm.user.name ?? "")
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
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: {presentationMode.wrappedValue.dismiss()}) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 35, height:  35)
                    .foregroundColor(.black.opacity(0.5))
                    .overlay {
                        Image(systemName: "xmark")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    .padding(.top, height / 10)
                    .padding(.trailing, 20)
            }
        }
    }
    
    private var reposView: some View {
        VStack {
            Text("Repos \(vm.user.public_repos ?? 0)")
                .font(.title2)
                .bold()
                .offset(y: 20)
            ScrollView(.horizontal) {
                HStack {
                    ForEach((0..<(vm.user.public_repos ?? 0)), id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(
                                width: width / 1.4,
                                height: height / 6
                            )
                            .foregroundColor(Color("card"))
                            .shadow(color: Color("shadow"), radius: 5)
                            .padding()
                    }
                }
            }
        }
    }
    
}
