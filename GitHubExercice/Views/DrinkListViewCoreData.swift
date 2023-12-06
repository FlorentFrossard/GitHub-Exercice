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
    @EnvironmentObject var drinkRequest: DrinkAPIRequestViewModel
    @EnvironmentObject var userSession: User
    
    //CORE DATA
    @FetchRequest(sortDescriptors: []) var favoriteDrink: FetchedResults<Favorite>
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(drinkRequest.allDrink) { drink in
                        NavigationLink(destination: DrinkDetailView(id: drink.id), label: {
                            
                                
                            HStack(alignment: .top) {
                                    if let imageFound = drink.image.first {
                                        AsyncImagePhases(unwrappedImageURL: imageFound.url, widthFrame: 100, heightFrame: 100)
                                       
                                    }
                                
                                if let index = drinkRequest.allDrink.firstIndex(where:{$0.id == drink.id}) {
                                    
                                    VStack(alignment: .leading) {
                                        Text(drink.name)
                                        Text(drinkRequest.formatPrice(index: index))
                                    }
                                    
                                    Spacer()
                                    Button {
                                        //$0.id -> n'importe quel élément de l'array allDrink
                                        //drink.id -> mot clé de mon ForEach
                                        //on compare les id des deux pour les identifier
                                        //si les drinks correspondent on stock l'index (firstIndex)
                                        
                                            //si la valeur favorite == true
                                            if drinkRequest.allDrink[index].favorite == true {
                                                
                                                
                                                drinkRequest.allDrink[index].favorite = false
                                                print(drinkRequest.allDrink[index].favorite!)
                                                
                                                //on fait la même chose pour la partie Core Data
                                                if let favIndex = favoriteDrink.firstIndex(where: { $0.id == drink.id}) {
                                                    favoriteDrink[favIndex].favorite = false
                                                    //puis on enlève l'élément de nos favoris via le context
                                                    //et on sauvegarde le changement
                                                    moc.delete(favoriteDrink[favIndex])
                                                    if moc.hasChanges {
                                                        try? moc.save()
                                                    }
                                                }
//
                                                
                                                
                                            } else {
                                                //tel élément je te transform en true
                                                drinkRequest.allDrink[index].favorite = true
                                                
                                                //lorsqu'on appuis sur l'étoile on ajoute un objet Favorite dans notre context
                                                //on renseigne les infos dont on a besoin
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




