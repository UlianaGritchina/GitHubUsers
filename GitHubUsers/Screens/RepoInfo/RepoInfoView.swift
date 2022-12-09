import SwiftUI

struct RepoInfoView: View {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    @Binding var repo: Repository
    let userAvatarImageData: Data
    var body: some View {
        NavigationView {
            ZStack {
                Image(uiImage: UIImage(data: userAvatarImageData) ?? UIImage(named: "Octocat")!)
                    .resizable()
                    .scaledToFill()
                Rectangle()
                    .foregroundColor(Color("sheet"))
                    .opacity(0.5)
                    .background(.ultraThinMaterial)
            }
            .ignoresSafeArea()
            .navigationTitle(repo.name ?? "")
        }
    }
}

struct RepoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RepoInfoView(
            repo: .constant(FakeDataManager.instance.getRepo()),
            userAvatarImageData: Data()
        )
    }
}


