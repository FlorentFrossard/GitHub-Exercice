//
//  RootView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import SwiftUI

struct RootView: View {
    
    //le @StateObject est comme un @State mais sur toute l'app
    //il doit être initialiser (prêt à l'emploi) dès l'ouverture de l'application
    //c'est un objet qui communique avec toutes les vues
    @StateObject var userRequest = UserAPIRequestViewModel()
    @StateObject var drinkRequest = DrinkAPIRequestViewModel()
    
    //mon objet User est massif à cause des images, si vous voulez simuler un utilisateur enregistré vous devez partir d'un point de départ comme ici
    //sinon impossible de stocker les informations que l'utilisateur renseigne
    @StateObject var userSession = User(id: "989zfozrg8723", name: "Zo", status: "Feels cold", notes: "Tea and hot chocolate baby~", image: [DataBaseImage(id: "zigjzprigj", width: 1000, height: 1000, url: "", filename: "day16-retro-cassette", size: 2800, type: "image/jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))], drink: [String](), idFromDrink: [String]())
    
    
    
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
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
            
        }
        .onAppear {
            Task {
                userRequest.allUser = await userRequest.fetchedUser()
                drinkRequest.allDrink = await drinkRequest.fetchedDrinks()
            }
        }
        //on applique l'objet sur tout l'environment de l'app
        //sinon le @StateObject perd son utilité
        //si vous en avez trop, fait une grosse classe qui appel tout
        .environmentObject(userRequest)
        .environmentObject(drinkRequest)
        .environmentObject(userSession)
        
    }
}

#Preview {
    RootView()
}
