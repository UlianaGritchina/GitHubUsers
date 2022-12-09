import SwiftUI

struct FindUserView: View {
    @StateObject var vm = FindUserViewModel()
    var body: some View {
        NavigationView {
            VStack {
                SearchUserTextFieldView(username: $vm.username).padding()
                if vm.networkState == .loading {
                    ProgressView()
                }
                if vm.networkState == .error {
                    Text("Error. 🛑").font(.headline)
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
    private var findButton: some View {
        Button(action: {
            vm.findUser()
            hideKeyboard()
        }) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: UIScreen.main.bounds.width / 2, height: 45)
                .overlay {
                    Text("Find")
                        .font(.headline)
                        .foregroundColor(Color("buttonsTitle"))
                }
        }
    }
    
}
