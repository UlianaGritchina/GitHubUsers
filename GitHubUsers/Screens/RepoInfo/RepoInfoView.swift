import SwiftUI

struct RepoInfoView: View {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    let repo: Repository
    @Binding var isShowingRepoInfo: Bool
    var body: some View {
        VStack {
            Spacer()
            sheet.overlay { infoView  .padding() }
        }
        .ignoresSafeArea()
        .offset(y: isShowingRepoInfo ? 0 : height)
        .onTapGesture {
            withAnimation(.spring()) {
                isShowingRepoInfo.toggle()
            }
        }
    }
}

struct RepoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RepoInfoView(
            repo: Repository(
                name: "name",
                description: "dfaldjlfjdljdfaldjlfjdljfljsadlgjkjlgjkjsdalgjklfljsadlgjkjlgjkjsdalgjkl",
                html_url: "",
                stargazers_count: 4,
                language: "swift",
                visibility: "public"),
            isShowingRepoInfo: .constant(true)
        )
    }
}


extension RepoInfoView {
    
    private var sheet: some View {
        RoundedRectangle(cornerRadius: 15)
            .opacity(0)
            .frame(width: width, height:  height / 2)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
    }
    
    private var infoView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(repo.name ?? "")
                        .font(.title)
                    Text("⭐️\(repo.stargazers_count ?? 0)")
                    Text("Language: " + (repo.language ?? ""))
                        .font(.headline)
                }
                Spacer()
            }
            Text(repo.description ?? "no description")
                .font(.system(size: height / 40))
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Button(action: {}) {
                Text("show in github")
                    .padding(9)
                    .padding(.horizontal, 25)
                    .foregroundColor(.white)
                    .font(.headline)
                    .background(Color.blue.cornerRadius(10))
            }.padding(.bottom)
        }
    }
    
}
