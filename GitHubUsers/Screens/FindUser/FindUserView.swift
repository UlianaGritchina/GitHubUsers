import SwiftUI

struct FindUserView: View {
    @StateObject var vm = FindUserViewModel()
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
                    UserRowView(user: vm.user, avatarImageData: vm.avatarImageData)
                }
                Spacer()
                findButton.padding(.bottom)
            }
            .navigationTitle("Find User")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        FindUserView()
    }
}


//MARK: VIEW COMPONENTS
extension FindUserView {
    
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
    
}
