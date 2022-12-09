import SwiftUI

struct StarsView: View {
    let stars: Int
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.headline)
            Text("\(stars)")
        }
        .font(.headline)
    }
}


struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView(stars: 62)
    }
}
