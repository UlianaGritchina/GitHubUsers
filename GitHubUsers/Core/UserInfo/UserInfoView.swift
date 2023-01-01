import SwiftUI

struct UserInfoView: View {
    @ObservedObject var vm: UserInfoViewModel
    @Environment(\.presentationMode) var presentationMode
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    @State private var opacity: Double = 0
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    image(geo: geometry)
                }
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height / 2.7
                )
                VStack {
                    UserBaseInfoCardView(user: vm.user)
                    if vm.loadRepos == .loaded {
                        ReposView(
                            avatarImageData: vm.user.avatarImageData ?? Data(),
                            repos: vm.repos,
                            stars: vm.starsCount
                        )
                    } else {
                        ProgressView()
                    }
                    Spacer()
                }
                .padding(.top)
                .background(Color.card)
            }
        }
        .background(Color.card)
        .overlay(navBar, alignment: .top)
        .onAppear {
            vm.getRepos()
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(
            vm: UserInfoViewModel(user: FakeDataManager.instance.getUser())
        )
    }
}


//MARK: - VIEW COMPONENTS

extension UserInfoView {
    
    private var avatarImageView: some View {
        vm.avatarImage
            .resizable()
            .scaledToFill()
            .overlay(usernameView, alignment: .bottom)
            .frame(width: width, height: height / 4)
    }
    
    private var usernameView: some View {
        Text(vm.user.name ?? vm.user.login ?? "")
            .bold()
            .font(.largeTitle)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
    }
    
    private func image(geo: GeometryProxy) -> some View {
        vm.avatarImage
            .resizable()
            .scaledToFill()
            .overlay(usernameView, alignment: .bottom)
            .frame(
                width: UIScreen.main.bounds.width,
                height: geo.frame(in: .global).minY > 0
                ?  geo.frame(in: .global).minY + (UIScreen.main.bounds.height / 3)
                : UIScreen.main.bounds.height / 3
            )
            .offset(y: -geo.frame(in: .global).minY)
            .onChange(of: geo.frame(in: .global).minY) { newValue in
                DispatchQueue.main.async {
                    withAnimation {
                        if newValue <= -197 {
                            opacity = 1
                        } else {
                            opacity = 0
                        }
                    }
                }
            }
    }
    
    private var navBar: some View {
        HStack {
            CircleButton(
                image: Image(systemName: "xmark"),
                action: { presentationMode.wrappedValue.dismiss() }
            )
            Spacer()
            Text(vm.user.name ?? "")
                .font(.headline)
                .opacity(opacity)
            Spacer()
            CircleButton(
                image: Image(systemName: vm.isPinned ? "pin.fill" : "pin"),
                action: { vm.pinUser() }
            )
        }
        .padding()
        .background(.ultraThinMaterial.opacity(opacity))
    }
    
    private var backButton: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Circle()
                .foregroundColor(.white)
                .frame(width: 35, height: 35)
                .overlay(Image(systemName: "chevron.down")
                    .foregroundColor(.black))
                .font(.headline)
        }
    }
    
}

