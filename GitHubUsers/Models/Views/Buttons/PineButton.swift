import SwiftUI

struct PineButton: View {
    let action: () -> ()
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 35, height:  35)
                .foregroundColor(.black.opacity(0.5))
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
        PineButton(action: {})
    }
}
