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
                if vm.networkState == .error {
                    Text("Error. Try it later.")
                        .font(.headline)
                }
                UserRowView(user: vm.user)
                    .opacity(vm.networkState == .loaded ? 1 : 0)
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
        RoundedRectangle(cornerRadius: 10)
            .frame(width: width - 40, height: 40)
            .foregroundColor(.gray.opacity(0.15))
            .overlay {
                TextField("🔍Username", text: $vm.username)
                    .font(.headline)
                    .padding()
            }
    }
    
    private var findButton: some View {
        Button(action: {
            vm.findUser()
            hideKeyboard()
        }) {
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
