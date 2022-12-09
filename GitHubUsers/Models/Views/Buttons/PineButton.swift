import SwiftUI

struct PineButton: View {
    @Binding var isTapeed: Bool
    let action: () -> ()
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 35, height:  35)
                .foregroundColor(isTapeed ? .blue.opacity(0.8) : .black.opacity(0.5))
                .overlay {
                    Image(systemName: "pin.fill")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
        }
    }
}

struct PineButton_Previews: PreviewProvider {
    static var previews: some View {
        PineButton(isTapeed: .constant(false), action: {})
    }
}
