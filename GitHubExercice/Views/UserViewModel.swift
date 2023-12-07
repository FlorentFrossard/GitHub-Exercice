//
//  UserViewModel.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 06/12/2023.
//

import SwiftUI
import CoreData

class UserViewModel: ObservableObject {
    
//    @FetchRequest(sortDescriptors: []) var favoriteDrink: FetchedResults<Favorite>
//    @Environment(\.managedObjectContext) var moc
    
//  l'utilisateur enregistré
    @Published var user = User(id: "989zfozrg8723", name: "Zo", status: "Feels cold man", notes: "Tea and hot chocolate baby~", image: [DataBaseImage(id: "zigjzprigj", width: 1000, height: 1000, url: "", filename: "day16-retro-cassette", size: 2800, type: "image/jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))], drink: [String](), idFromDrink: [String]())
    
//MARK: FUNCTIONS FOR API AND CLASS NOTIONS
    func addDrinksToFavorite(chosenDrink drinkRequest: DrinkAPIRequestViewModel, index: Int) {
        user.idFromDrink.append(drinkRequest.allDrink[index].id)
    }
    
    func removeDrinksFromFavorite(idFromDrink id: String) {
        if let favIndex = user.idFromDrink.firstIndex(where: {$0 == id}) {
            //on retire de ces favoris l'élément qui correspond en fonction de l'index récup a la ligne du dessus
            user.idFromDrink.remove(at: favIndex)
            
        }
    }

//MARK: FUNCTIONS FOR CORE DATA NOTIONS
    
    //lorsqu'on appuis sur l'étoile on ajoute un objet Favorite dans notre context
    //on renseigne les infos dont on a besoin
    func addCoreDataDrinksToFavorite(chosenDrink drinkRequest: DrinkAPIRequestViewModel, index: Int, CoreDataContext moc: NSManagedObjectContext) {
        let newFav = Favorite(context: moc)
        newFav.name = drinkRequest.allDrink[index].name
        newFav.favorite = drinkRequest.allDrink[index].favorite!
        newFav.id = drinkRequest.allDrink[index].id
        newFav.price = drinkRequest.allDrink[index].price
        newFav.user = user.id
        newFav.image = drinkRequest.allDrink[index].image[0].url
        
        //puis on sauvegarde si un changement a eu lieu
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
    //on supprime l'élément sur lequel on a appuyé
    //on demande au context (moc) si il a observé des modifications
    //si oui on sauvegarde la mise à jour
    //ici on enlève dans persistentStore la donnée sélectionnée
    func removeCoreDataDrinksFromFavorite(drink: Drink, fetchedRequest favoriteDrink: FetchedResults<Favorite>, CoreDataContext moc: NSManagedObjectContext) {
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
