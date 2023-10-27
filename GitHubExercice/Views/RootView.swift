//
//  RootView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var userRequest = UserAPIRequest()
    @StateObject var drinkRequest = DrinkAPIRequestViewModel()
    
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
            DrinkListView()
                .tabItem {
                    Label("Selections", systemImage: "mug.fill")
                }
            
        }
        .onAppear {
            Task {
                userRequest.allUser = await userRequest.fetchedUser()
                drinkRequest.allDrink = await drinkRequest.fetchedDrinks()
            }
        }
        .environmentObject(userRequest)
        .environmentObject(drinkRequest)
        
        
    }
}

#Preview {
    RootView()
}
