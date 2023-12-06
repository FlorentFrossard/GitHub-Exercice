//
//  DrinkListView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 27/10/2023.
//

import SwiftUI

struct DrinkListView: View {
    
    //ici on a au moins besoin du pull API des Drinks
    //mais aussi de l'utilisateur renseigné car seul lui peut mettre en favoris ces éléments
    @EnvironmentObject var drinkRequest: DrinkAPIRequestViewModel
    @EnvironmentObject var userSession: User
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(drinkRequest.allDrink) { drink in
                        ExtractedDrinkCard(id: drink.id)
                    }
                }
                .padding()
            .navigationTitle("Notre sélections")
            }
        }
    }
}

#Preview {
    DrinkListView()
        .environmentObject(DrinkAPIRequestViewModel())
}

struct ExtractedDrinkCard: View {
    @EnvironmentObject var drinkRequest: DrinkAPIRequestViewModel
    @EnvironmentObject var userSession: User
    var id: String
    var body: some View {
        if let index = drinkRequest.allDrink.firstIndex(where:{$0.id == id}) {
        HStack(alignment: .top) {
            if let imageFound = drinkRequest.allDrink[index].image.first {
                AsyncImagePhases(unwrappedImageURL: imageFound.url, widthFrame: 100, heightFrame: 100)
            }
            
            Text(drinkRequest.allDrink[index].name)
         
            Button {
                //$0.id -> n'importe quel élément de l'array allDrink
                //drink.id -> mot clé de mon ForEach
                //on compare les id des deux pour les identifier
                //si les drinks correspondent on stock l'index (firstIndex)
               
                    
                    //si la valeur favorite == true
                    if drinkRequest.allDrink[index].favorite == true {
                        
                        //transforme la valeur en false parce qu'on appuis sur le même button, donc on retire de nos favoris cette élément
                        drinkRequest.allDrink[index].favorite = false
                        
                        //l'utilisateur enregistré à un array d'id ou y sont les Drink = Drink.id -> idFromDrink
                        //on compare ça avec le drink.id du ForEach
                        if let favIndex = userSession.idFromDrink.firstIndex(where: {$0 == id}) {
                            //on retire de ces favoris l'élément qui correspond en fonction de l'index récup a la ligne du dessus
                            //MARK: REMOVE FROM FAV DRINKS FOR API AND CLASS
                            
                            
                        }
                    } else {
                        //tel élément je te transform en true
                        drinkRequest.allDrink[index].favorite = true
                        
                        //on ajoute dans mon array favoris (idFromDrink) l'id de l'élément sélectionné
                        //MARK: ADD TO FAV DRINKS FOR API AND CLASS
                    }
              
                
                
            } label: {
                Image(systemName: drinkRequest.allDrink[index].favorite == true ? "star.fill" : "star")
            }
           
            
        }
    }
    }
}
