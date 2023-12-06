//
//  UserViewModel.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 06/12/2023.
//

import SwiftUI

class UserViewModel: ObservableObject {
    
    @FetchRequest(sortDescriptors: []) var favoriteDrink: FetchedResults<Favorite>
    @Environment(\.managedObjectContext) var moc
    
//  l'utilisateur enregistré
    @Published var userSession = User(id: "989zfozrg8723", name: "Zo", status: "Feels cold man", notes: "Tea and hot chocolate baby~", image: [DataBaseImage(id: "zigjzprigj", width: 1000, height: 1000, url: "", filename: "day16-retro-cassette", size: 2800, type: "image/jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))], drink: [String](), idFromDrink: [String]())
    
//MARK: FUNCTIONS FOR API AND CLASS NOTIONS
    func addDrinksToFavorite(chosenDrink drinkRequest: DrinkAPIRequestViewModel, index: Int) {
        userSession.idFromDrink.append(drinkRequest.allDrink[index].id)
    }
    
    func removeDrinksFromFavorite(idFromDrink id: String) {
        if let favIndex = userSession.idFromDrink.firstIndex(where: {$0 == id}) {
            //on retire de ces favoris l'élément qui correspond en fonction de l'index récup a la ligne du dessus
            userSession.idFromDrink.remove(at: favIndex)
            
        }
    }

//MARK: FUNCTIONS FOR CORE DATA NOTIONS
    func addCoreDataDrinksToFavorite(chosenDrink drinkRequest: DrinkAPIRequestViewModel, index: Int) {
        let newFav = Favorite(context: moc)
        newFav.name = drinkRequest.allDrink[index].name
        newFav.favorite = drinkRequest.allDrink[index].favorite!
        newFav.id = drinkRequest.allDrink[index].id
        newFav.price = drinkRequest.allDrink[index].price
        newFav.user = userSession.id
        newFav.image = drinkRequest.allDrink[index].image[0].url
        
        //puis on sauvegarde si un changement a eu lieu
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
    func removeCoreDataDrinksFromFavorite(drink: Drink) {
        if let favIndex = favoriteDrink.firstIndex(where: { $0.id == drink.id}) {
            favoriteDrink[favIndex].favorite = false
            //puis on enlève l'élément de nos favoris via le context
            //et on sauvegarde le changement
            moc.delete(favoriteDrink[favIndex])
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}
