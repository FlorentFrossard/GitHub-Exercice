//
//  UserSessionProfilCoreData.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 07/12/2023.
//

import SwiftUI

struct UserSessionProfilCoreData: View {
    @EnvironmentObject var userSession: UserViewModel
    @EnvironmentObject var drinkRequest: DrinkAPIRequestViewModel
    
    //CORE DATA
        @FetchRequest(sortDescriptors: []) var favoriteDrink: FetchedResults<Favorite>
        @Environment(\.managedObjectContext) var moc
    var body: some View {
        NavigationStack {
            VStack {
                Image(userSession.user.image[0].filename)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                            .clipped()
                
                Text(userSession.user.name)
                    .font(.largeTitle)
                Text(" \"\(userSession.user.notes)\"")
                Text(userSession.user.status)
                    .foregroundStyle(Color.gray)
                
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Mes favoris")
                            .padding()
                        Spacer()
                    }
                    
                    //on fait la même chose ici que ce qui est fait plus haut
                    //check entre deux id
                    if favoriteDrink.isEmpty {
                        Text("Vous n'avez rien ajouté dans votre liste de favoris")
                            .padding(.horizontal)
                        
                    } else {
                        ScrollView {
                            
                            ForEach(favoriteDrink) { favDrink in
                                HStack(alignment: .top) {
                                    
                                    AsyncImagePhases(unwrappedImageURL: favDrink.wrappedImage, widthFrame: 100, heightFrame: 100)
                                    
                                    Text(favDrink.wrappedName)
                                    Spacer()
                                    Button {
                                        //ici on vérifie si les deux ids correspondent histoire d'identifier les éléments
                                        //en résultat on récup un index
                                        if let favIndex = favoriteDrink.firstIndex(where: { $0.id == favDrink.id }) {
                                            
                                            if let index = drinkRequest.allDrink.firstIndex(where: { $0.id == favDrink.id }) {
                                                drinkRequest.allDrink[index].favorite = false
                                                //pointer l'élément dont sa valeur changé a false pour la supprimer
                                                favoriteDrink[favIndex].favorite = false
                                                //appel de la fonction qui retire les drinks des favoris
                                                userSession.removeCoreDataDrinksFromFavorite(drink: drinkRequest.allDrink[index], fetchedRequest: favoriteDrink, CoreDataContext: moc)
                                            }
                                            
                                        }
                                            
                                            
                                            
                                            
                                            
                                            
                                           
                                            
                                            

                                            
                                            
                                        
                                    } label: {
                                        Image(systemName: "star.fill")
                                    }
                                    .foregroundStyle(.yellow)
                                    
                                    
                                }
                            }
                        }
                        .padding()
                    }
                }
                
                Spacer()
                
            }.navigationTitle("Profil")
        }
    }
}

//#Preview {
//    UserSessionProfilCoreData()
//}
