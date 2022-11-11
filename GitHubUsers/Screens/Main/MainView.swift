
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
        Button(action: {vm.findUser()}) {
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
                    height: UIScreen.main.bounds.width / 1.5
                )
                .foregroundColor(.white)
                .shadow(color: .gray.opacity(0.4), radius: 5)
                .blur(radius: 0.5)
                .overlay { userPrewiewContent.padding() }
        }
    }
    
    private var userPrewiewContent: some View {
        VStack {
            Circle()
                .frame(width: UIScreen.main.bounds.width / 2)
            HStack {
                VStack(alignment: .leading) {
                    Text("Name").font(.headline)
                    Text("Bio")
                    Text("location")
                }
                .foregroundColor(.black)
                .padding(.horizontal, 40)
                Spacer()
            }
        }
    }
    
}
