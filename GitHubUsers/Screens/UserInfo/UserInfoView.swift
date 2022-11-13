
import SwiftUI

struct UserInfoView: View {
    let user: User
    let userAvatarImageData: Data
    let defoultImage: UIImage = UIImage(named: "Octocat")!
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
                VStack() {
                    userInfoView.padding(.top, height / 2.6)
                    if let reposCount = user.public_repos {
                        reposView
                    }
                    Spacer()
                    
                }
                
            }
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(
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
                created_at: ""),
            userAvatarImageData: Data()
        )
    }
}

extension UserInfoView {
    
    private var avatarImageView: some View {
        Image(uiImage: UIImage(data: userAvatarImageData) ?? defoultImage)
            .resizable()
            .scaledToFill()
            .overlay {
                VStack {
                    closeButton
                    Spacer()
                    HStack {
                        Text(user.name ?? "")
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
                if let bio = user.bio {
                    Text(bio).bold()
                }
                if let location = user.location {
                    Text(location)
                }
                if let followers = user.followers {
                    Text("Followers: \(followers)")
                }
                if let following = user.following {
                    Text("Following: \(following)")
                }
            }
            .font(.system(size: UIScreen.main.bounds.height / 40))
            Spacer()
        }
        .padding()
        .frame(width: width - 20)
        .background(Color("card").cornerRadius(10))
        .shadow(color: Color("shadow"), radius: 5)
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
            Text("Repos \(user.public_repos ?? 0)")
                .font(.title)
                .bold()
                .offset(y: 20)
            ScrollView(.horizontal) {
                HStack {
                    ForEach((0..<(user.public_repos ?? 0)), id: \.self) { _ in
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
