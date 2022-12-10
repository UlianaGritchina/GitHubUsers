import SwiftUI

struct LoadingView: View {
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    var body: some View {
        ZStack {
            HStack {
                Circle()
                    .offset(y: count == 1 ? -15 : 0)
                    .foregroundColor(count == 1 ? .green : .black)
                Circle()
                    .offset(y: count == 2 ? -15 : 0)
                    .foregroundColor(count == 2 ? .green : .black)
                Circle()
                    .offset(y: count == 3 ? -15 : 0)
                    .foregroundColor(count == 3 ? .green : .black)
            }
            .frame(width: 50, height: 50)
            .padding()
            .background(
                Circle()
                    .foregroundColor(.buttonsTitle)
                    .shadow(radius: 5)
            )
            .onReceive(timer, perform: { _ in
                withAnimation(.easeIn(duration: 0.5)) {
                    count = count == 3 ? 0 : count + 1
                }
            })
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
