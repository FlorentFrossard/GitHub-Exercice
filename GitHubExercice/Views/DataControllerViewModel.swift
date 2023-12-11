//
//  DataControllerViewModel.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 30/10/2023.
//

import Foundation

class DataControllerViewModel: ObservableObject  {
    //si vous ne voulez pas créer de class pour votre donnée passer par un intermédiaire
    //et appeler uniquement cette objet comme @StateObject dans la racine
    //vous pouvez créer une class qui appel d'autre pour gérer toute la donnée au moment
    
    var usersAPIRequests = UserAPIRequestViewModel()
    var drinksAPIRequests = DrinkAPIRequestViewModel()
    
    //tableaux de donnée modulable
    @Published var allDrinks = [Drink]()
    @Published var allUsers = [User]()
    
    func formatPrice(index: Int) -> String {
       String(format: "%.2f", self.allDrinks[index].price)
    }
    
    
}
