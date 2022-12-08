import SwiftUI

struct UserBaseInfoCardView: View {
    let user: User
    var body: some View {
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
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(
            Color("card")
                .cornerRadius(10)
                .shadow(color: Color("shadow"), radius: 5)
        )
    }
}

struct UserBaseInfoCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserBaseInfoCardView(user: FakeDataManager.instance.getUser())
    }
}
