import SwiftUI

struct PineButton: View {
    @Binding var isTapeed: Bool
    let action: () -> ()
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 35, height:  35)
                .foregroundColor(.white)
                .overlay {
                    Image(systemName: isTapeed ? "pin.fill" : "pin")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
        }
    }
}

struct PineButton_Previews: PreviewProvider {
    static var previews: some View {
        PineButton(isTapeed: .constant(false), action: {})
    }
}
