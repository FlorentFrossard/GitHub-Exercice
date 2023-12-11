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
    @StateObject var dataController = DataControllerViewModel()
    
    //mon objet User est massif à cause des images, si vous voulez simuler un utilisateur enregistré vous devez partir d'un point de départ comme ici
    //sinon impossible de stocker les informations que l'utilisateur renseigne
//    retravaille de la donnée pour isoler l'utilisateur enregistré et lui donner les fonctions d'ajouter/retirer des favoris
    @StateObject var userSession = UserViewModel()
    
    
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
            DrinkListViewCoreData()
                .tabItem {
                    Label("Selections", systemImage: "mug.fill")
                }
            ProfileViewCoreData()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
            
        }
        .toolbar(.visible, for: .tabBar)
        .toolbarBackground(Color.red, for: .tabBar)
        
        .onAppear {
            Task {
                dataController.allUsers = await dataController.usersAPIRequests.fetchedUsers()
                dataController.allDrinks = await dataController.drinksAPIRequests.fetchedDrinks()
            }
        }
        //on applique l'objet sur tout l'environment de l'app
        //sinon le @StateObject perd son utilité
        //si vous en avez trop, fait une grosse classe qui appel tout
        .environmentObject(userSession)
        .environmentObject(dataController)
        
        
    }
}

#Preview {
    RootView()
}
