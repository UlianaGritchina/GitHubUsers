//
//  SquareButton.swift
//  GitHubUsers
//
//  Created by Ульяна Гритчина on 01.01.2023.
//

import SwiftUI

struct CircleButton: View {
    let image: Image
    let action: () -> ()
    var body: some View {
        Button(action: action) {
            Circle()
                .frame(width: 40, height:  40)
                .foregroundColor(.white)
                .blur(radius: 0.5)
                .overlay {
                    image
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                }
        }
    }
}

struct SquareButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(image: Image(systemName: "heart"), action: {})
    }
}
