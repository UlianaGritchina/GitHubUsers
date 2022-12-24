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
                
                Text("Joined GitHub \(getJoinedDate(from: user.created_at))")
                    .font(.subheadline)
                    .padding(.top, 1)
                
            }
            .font(.system(size: UIScreen.main.bounds.height / 40))
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(
            Color.card
                .cornerRadius(10)
                .shadow(color: .shadow, radius: 5)
        )
    }
    
   private func getJoinedDate(from dateString: String?) -> String {
        guard let dateString = dateString else { return "" }
        var newDateString = ""
        for char in dateString {
            if char != "T" {
                newDateString.append(char)
            } else {
                break
            }
        }
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        guard let date = dateFormatterGet.date(from: newDateString) else { return "" }
        return dateFormatterPrint.string(from: date)
    }
    
    
}

struct UserBaseInfoCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserBaseInfoCardView(user: FakeDataManager.instance.getUser())
    }
}
