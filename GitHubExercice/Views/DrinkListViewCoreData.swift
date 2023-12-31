//
//  DrinkListViewCoreData.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 01/11/2023.
//

import SwiftUI

struct DrinkListViewCoreData: View {
    
    //ici on a au moins besoin du pull API des Drinks
    //mais aussi de l'utilisateur renseigné car seul lui peut mettre en favoris ces éléments
    @EnvironmentObject var dataController: DataControllerViewModel
    @EnvironmentObject var userSession: UserViewModel
    
//    //CORE DATA
    @FetchRequest(sortDescriptors: []) var favoriteDrink: FetchedResults<Favorite>
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(dataController.allDrinks) { drink in
                        NavigationLink(destination: DrinkDetailView(id: drink.id), label: {
                            
                                
                            HStack(alignment: .top) {
                                    if let imageFound = drink.image.first {
                                        AsyncImagePhases(unwrappedImageURL: imageFound.url, widthFrame: 100, heightFrame: 100)
                                       
                                    }
                                
                                if let index = dataController.allDrinks.firstIndex(where:{$0.id == drink.id}) {
                                    
                                    VStack(alignment: .leading) {
                                        Text(drink.name)
                                        Text(dataController.formatPrice(index: index))
                                    }
                                    
                                    Spacer()
                                    Button {
                                        //$0.id -> n'importe quel élément de l'array allDrink
                                        //drink.id -> mot clé de mon ForEach
                                        //on compare les id des deux pour les identifier
                                        //si les drinks correspondent on stock l'index (firstIndex)
                                        
                                            //si la valeur favorite == true
                                            if dataController.allDrinks[index].favorite == true {
                                                dataController.allDrinks[index].favorite = false
                                                
                                                //on fait la même chose pour la partie Core Data
                                                userSession.removeCoreDataDrinksFromFavorite(drink: dataController.allDrinks[index], fetchedRequest: favoriteDrink, CoreDataContext: moc)
                                                
                                                
                                            } else {
                                                //tel élément je te transform en true
                                                dataController.allDrinks[index].favorite = true
                                                
                                                userSession.addCoreDataDrinksToFavorite(chosenDrink: dataController, index: index, CoreDataContext: moc)
                                            }
                                      
                                    } label: {
                                        Image(systemName: drink.favorite == true ? "star.fill" : "star")
                                            .foregroundStyle(.yellow)
                                    }
                                }
                                }
                        })
                        .foregroundStyle(.black)
                    }
                }
                .padding()
            .navigationTitle("Notre sélections")
            }
        }
    }
}

#Preview {
    DrinkListViewCoreData()
        .environmentObject(DrinkAPIRequestViewModel())
}




