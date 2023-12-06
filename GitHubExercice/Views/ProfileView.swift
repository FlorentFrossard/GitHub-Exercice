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
                            AsyncImagePhases(unwrappedImageURL: imageFound.url, widthFrame: 200, heightFrame: 200)
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
                                                        AsyncImagePhases(unwrappedImageURL: imageFound.url, widthFrame: 100, heightFrame: 100)
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
                UserSessionProfil()
            }
            
        }
    }
}

#Preview {
    ProfileView(user: User(id: "989zfozrg8723", name: "Zo", status: "Feels cold", notes: "Tea and hot chocolate baby~", image: [DataBaseImage(id: "zigjzprigj", width: 1000, height: 1000, url: "", filename: "day16-retro-cassette", size: 2800, type: "image/jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))], drink: [String](), idFromDrink: [String]()))
    
    
    
        .environmentObject(User(id: "989zfozrg8723", name: "Zo", status: "Feels cold", notes: "Tea and hot chocolate baby~", image: [DataBaseImage(id: "zigjzprigj", width: 1000, height: 1000, url: "", filename: "day16-retro-cassette", size: 2800, type: "image/jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))], drink: [String](), idFromDrink: [String]()))
}

