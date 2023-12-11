//
//  UserSessionProfil.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 01/12/2023.
//

import SwiftUI

struct UserSessionProfil: View {
    @EnvironmentObject var userSession: UserViewModel
    @EnvironmentObject var dataController: DataControllerViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(userSession.user.image[0].filename)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                Text(userSession.user.name)
                    .font(.largeTitle)
                Text(" \"\(userSession.user.notes)\"")
                Text(userSession.user.status)
                    .foregroundStyle(Color.gray)
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Mes favoris")
                    
                    //on fait la même chose ici que ce qui est fait plus haut
                    //check entre deux id
                    if userSession.user.idFromDrink.isEmpty {
                        Text("Vous n'avez rien ajouté dans votre liste de favoris")
                    } else {
                        ScrollView {
                            ForEach(dataController.allDrinks) { drink in
                                ForEach(userSession.user.idFromDrink, id: \.self) { id in
                                    
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
