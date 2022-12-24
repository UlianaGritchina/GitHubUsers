import SwiftUI

struct RepoRowView: View {
    let repo: Repository
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame( width: width / 1.4, height: height / 6)
            .foregroundColor(.card)
            .shadow(color: .shadow, radius: 5)
            .overlay { contentView.padding() }
    }
}

struct RepoRowView_Previews: PreviewProvider {
    static var previews: some View {
        RepoRowView(repo: FakeDataManager.instance.getRepo())
    }
}


extension RepoRowView {
    private var contentView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(repo.name ?? "")
                    .font(.title2)
                    .bold()
                StarsView(stars: repo.stargazers_count ?? 0)
                Text(repo.language ?? "").font(.headline)
                Spacer()
            }
            Spacer()
            VStack {
                Spacer()
                Text(repo.visibility ?? "")
            }
        }
    }
}
