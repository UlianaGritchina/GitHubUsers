import SwiftUI

struct SearchUserTextFieldView: View {
    @Binding var username: String
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
            .foregroundColor(.gray.opacity(0.15))
            .overlay {
                HStack {
                    Text("🔍")
                    TextField("Username", text: $username)
                        .font(.headline)
                }
                .padding()
            }
    }
}

struct SearchUserTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserTextFieldView(username: .constant(""))
    }
}
