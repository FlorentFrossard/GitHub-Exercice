//
//  RootView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var userRequest = UserAPIRequest()
    
    var body: some View {
        TabView {
            UserListView()
                .tabItem {
                    Label("Connexions", systemImage: "person.2")
                }
            Color.red
                .tabItem {
                    Label("Toto", systemImage: "person")
                }
        }
        .onAppear {
            Task {
                userRequest.allUser = await userRequest.fetchedUser()
            }
        }
        .environmentObject(userRequest)
        
        
    }
}

#Preview {
    RootView()
}
