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
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            UserListView()
                .tabItem {
                    Label("Connexions", systemImage: "person.3.fill")
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
