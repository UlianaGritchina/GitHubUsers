
import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()
    var body: some View {
        NavigationView {
            VStack {
                usernameTF.padding()
                userPreviewCard
                Spacer()
                findButton
            }
            .navigationTitle("Find User")
            .sheet(isPresented: $vm.isShowingUserInfoView) {
                UserInfoView()
            }
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
            .frame(
                width: UIScreen.main.bounds.width - 40,
                height: UIScreen.main.bounds.height / 20
            )
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
                .frame(
                    width: UIScreen.main.bounds.width / 2,
                    height: 45
                )
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
                .frame(
                    width: UIScreen.main.bounds.width - 80,
                    height: UIScreen.main.bounds.width / 3
                )
                .foregroundColor(.white)
                .shadow(color: .gray.opacity(0.4), radius: 5)
                .blur(radius: 0.5)
                .overlay { userPrewiewContent.padding() }
        }
    }
    
    private var userPrewiewContent: some View {
        HStack {
            Circle().frame(width: UIScreen.main.bounds.width / 4)
            VStack(alignment: .leading, spacing: 10) {
                Text(vm.user.name ?? "noname").font(.headline)
                Text(vm.user.bio ?? "nobio")
                Text(vm.user.location ?? "nolocation")
            }
            .foregroundColor(.black)
            Spacer()
        }
    }
    
}
