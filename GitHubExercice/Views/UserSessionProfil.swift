//
//  UserSessionProfil.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 01/12/2023.
//

import SwiftUI

struct UserSessionProfil: View {
    @EnvironmentObject var userSession: User
    @EnvironmentObject var drinkRequest: DrinkAPIRequestViewModel
    
    var body: some View {
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
                                            AsyncImagePhases(unwrappedImageURL: imageFound.url, widthFrame: 100, heightFrame: 100)
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

#Preview {
    UserSessionProfil()
}
