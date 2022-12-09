import SwiftUI

struct ReposView: View {
    let avatarImageData: Data
    @State private var selectedRepo: Repository = FakeDataManager.instance.getRepo()
    @State private var isShowingRepoInfo = false
    let repos: [Repository]
    let stars: Int
    var body: some View {
        VStack {
            header
            ScrollView(.horizontal) {
                HStack {
                    ForEach(repos, id: \.self) { repo in
                        RepoRowView(repo: repo).padding()
                            .onTapGesture {
                                selectedRepo = repo
                                withAnimation(.spring()) {
                                    isShowingRepoInfo.toggle()
                                }
                            }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingRepoInfo) {
            RepoInfoView(repo: $selectedRepo, userAvatarImageData: avatarImageData)
        }
    }
}

struct ReposView_Previews: PreviewProvider {
    static var previews: some View {
        ReposView(avatarImageData: Data(),
                  repos: FakeDataManager.instance.getRepos(),
                  stars: 5)
    }
}

extension ReposView {
    
    private var header: some View {
        HStack {
            Text("Public repos \(repos.count)")
                .font(.title2)
                .bold()
            Spacer()
            StarsView(stars: stars)
        }
        .padding(.horizontal)
        .offset(y: 20)
    }
    
}


