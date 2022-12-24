import SwiftUI

struct CloseButton: View {
    let action: () -> ()
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 35, height:  35)
                .foregroundColor(.black.opacity(0.5))
                .overlay {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
        }
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(action: {})
    }
}
