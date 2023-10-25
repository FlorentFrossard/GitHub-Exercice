//
//  UserListView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import SwiftUI

struct UserListView: View {
    
    @EnvironmentObject var userRequest: UserAPIRequest
    
//    var user: User
    
    var body: some View {
        NavigationStack {
            LazyVStack {
                ForEach(userRequest.allUser) { user in
                    NavigationLink(destination: UserDetail(user: user), label: {
                        Text(user.name)
                    })
                   
                }
            }
        }
    }
}

struct UserDetail: View {
    
//    @EnvironmentObject var userRequest: UserAPIRequest
    
    var user: User
    
    var body: some View {
        Text(user.name)
    }
}

#Preview {
    UserListView()
    
}
