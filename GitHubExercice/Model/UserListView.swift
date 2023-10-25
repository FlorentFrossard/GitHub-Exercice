//
//  UserListView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import SwiftUI

struct UserListView: View {
    
    //ici on lit la variable observer dans les vues enfants via le @EnvironmentObjet
    @EnvironmentObject var userRequest: UserAPIRequest
    
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
    
    var user: User
    
    var body: some View {
        Text(user.name)
    }
}

#Preview {
    UserListView()
    
}
