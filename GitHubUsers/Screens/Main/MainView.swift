
import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        NavigationView {
            VStack {
                usernameTF.padding()
                if vm.networkState == .loading {
                    ProgressView()
                }
                if vm.networkState == .loaded {
                    userPreviewCard
                }
                Spacer()
                findButton.padding(.bottom)
            }
            .navigationTitle("Find User")
            .fullScreenCover(isPresented: $vm.isShowingUserInfoView, content: {
                UserInfoView(user: vm.user, userAvatarImageData: vm.avatarImageData)
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


//MARK: VIEW COMPONENTS
extension MainView {
    
    private var usernameTF: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: width - 40, height: height / 20)
            .foregroundColor(.gray.opacity(0.15))
            .overlay {
                TextField("Username", text: $vm.username)
                    .font(.headline)
                    .padding()
            }
    }
    
    private var findButton: some View {
        Button(action: vm.findUser) {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: width / 2, height: 45)
                .overlay {
                    Text("Find")
                        .font(.headline)
                        .foregroundColor(.white)
                }
        }
    }
    
    private var userPreviewCard: some View {
        Button(action: {vm.showUserInfo()}) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: width - 80, height: width / 3)
                .foregroundColor(Color("card"))
                .shadow(color: Color("shadow"), radius: 5)
                .blur(radius: 0.5)
                .overlay { userPrewiewContent.padding() }
        }
    }
    
    private var userPrewiewContent: some View {
        HStack {
            vm.avatarImage
                .resizable()
                .frame(width:width / 4, height: width / 4)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 10) {
                Text(vm.user.name ?? "noname").font(.headline)
                Text(vm.user.bio ?? "nobio")
                Text(vm.user.location ?? "nolocation")
            }
            .foregroundColor(Color("text"))
            Spacer()
        }
    }
    
}
