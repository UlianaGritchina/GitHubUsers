//
//  UsersListView.swift
//  GitHubUsers
//
//  Created by Ульяна Гритчина on 08.12.2022.
//

import SwiftUI

struct UsersListView: View {
    let users: [User]
    var body: some View {
        ScrollView {
            ForEach(users, id: \.self) { user in
                UserRowView(user: user).padding(.bottom)
            }
            .padding()
            .animation(.default, value: users)
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(users: [
            FakeDataManager.instance.getUser(),
            FakeDataManager.instance.getUser()
        ])
    }
}
