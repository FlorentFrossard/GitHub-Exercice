//
//  ProfileView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 30/10/2023.
//

import SwiftUI

struct ProfileView: View {
    //ce userSession correspond a l'utilisateur qui utilise son téléphone et/ou qui est enregistré
    @EnvironmentObject var userSession: User
    
    //comme on va afficher des drink il nous faut appeler tous Drink dans cette vue aussi
    @EnvironmentObject var drinkRequest: DrinkAPIRequestViewModel
    
    //et comme on veut utiliser la même vue de profil, au lieu de l'écrire 2 fois on passe en optionnel un User
    //si on a bien 1 autre utilisateur (différent de celui enregistré) alors on affiche cette utilisateur
    var user: User?
    
    var body: some View {
        ZStack {
            //ici on s'assure que le l'autre utilisateur est bien existant (l'optionnel)
            //si oui on rentre dans cette condition et on stock l'utilisateur existant dans unwrappedUser
            if let unwrappedUser = user {
                
                //ensuite on compare l'id de l'autre utilisateur avec l'id de celui connecté
                //si les id sont différent alors on on rentre dans le if pour afficher les infos du l'utilisateur optionnel
                if unwrappedUser.id != userSession.id {
                    VStack {
                        
                        if let imageFound = unwrappedUser.image.first {
                            AsyncImage(url: URL(string: imageFound.url)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } else if phase.error != nil {
                                    Text("Image indisponible")
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        }
                        
                        Text(unwrappedUser.name)
                            .font(.largeTitle)
                        Text(" \"\(unwrappedUser.notes)\"")
                        Text(unwrappedUser.status)
                            .foregroundStyle(Color.gray)
                        
                        
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Mes favoris")
                            
                            //on prend en compte la possibilité que l'utilisateur n'est pas encore de favoris
                            if unwrappedUser.idFromDrink.isEmpty {
                                Text("Vous n'avez rien ajouté dans votre liste de favoris")
                            } else {
                                //ici on fait correspondre les id des Drink entre elles pour voir si on arrive à faire matcher des Drink
                                //pour cela on a besoin du tableau idFromDrink provenant de notre User
                                //et de toute la donnée provenant du pull API, ici drinkRequest.allDrink
                                ScrollView {
                                    ForEach(drinkRequest.allDrink) { drink in
                                        ForEach(unwrappedUser.idFromDrink, id: \.self) { id in
                                            
                                            HStack {
                                                
                                                if drink.id == id {
                                                    if let imageFound = drink.image.first {
                                                        AsyncImage(url: URL(string: imageFound.url)) { phase in
                                                            if let image = phase.image {
                                                                image
                                                                    .resizable()
                                                                    .scaledToFill()
                                                            } else if phase.error != nil {
                                                                Image(systemName: "mug.full")
                                                            } else {
                                                                ProgressView()
                                                            }
                                                        }
                                                        .frame(width: 100, height: 100)
                                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                                    }
                                                    
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        
                        Spacer()
                        
                    }
                }
                //sinon on rentre dans ce block de condition où on affiche l'utilisateur connecté
            } else {
                NavigationStack {
                    VStack {
                        Image(userSession.image[0].filename)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        
                        Text(userSession.name)
                            .font(.largeTitle)
                        Text(" \"\(userSession.notes)\"")
                        Text(userSession.status)
                            .foregroundStyle(Color.gray)
                        
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Mes favoris")
                            
                            //on fait la même chose ici que ce qui est fait plus haut
                            //check entre deux id
                            if userSession.idFromDrink.isEmpty {
                                Text("Vous n'avez rien ajouté dans votre liste de favoris")
                            } else {
                                ScrollView {
                                    ForEach(drinkRequest.allDrink) { drink in
                                        ForEach(userSession.idFromDrink, id: \.self) { id in
                                            
                                            if drink.id == id {
                                                if let imageFound = drink.image.first {
                                                    AsyncImage(url: URL(string: imageFound.url)) { phase in
                                                        if let image = phase.image {
                                                            image
                                                                .resizable()
                                                                .scaledToFill()
                                                        } else if phase.error != nil {
                                                            Image(systemName: "mug.full")
                                                        } else {
                                                            ProgressView()
                                                        }
                                                    }
                                                    .frame(width: 100, height: 100)
                                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        Spacer()
                        
                    }.navigationTitle("Profil")
                }
            }
            
        }
    }
}

#Preview {
    ProfileView(user: User(id: "989zfozrg8723", name: "Zo", status: "Feels cold", notes: "Tea and hot chocolate baby~", image: [DataBaseImage(id: "zigjzprigj", width: 1000, height: 1000, url: "", filename: "day16-retro-cassette", size: 2800, type: "image/jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))], drink: [String](), idFromDrink: [String]()))
    
    
    
        .environmentObject(User(id: "989zfozrg8723", name: "Zo", status: "Feels cold", notes: "Tea and hot chocolate baby~", image: [DataBaseImage(id: "zigjzprigj", width: 1000, height: 1000, url: "", filename: "day16-retro-cassette", size: 2800, type: "image/jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))], drink: [String](), idFromDrink: [String]()))
}

