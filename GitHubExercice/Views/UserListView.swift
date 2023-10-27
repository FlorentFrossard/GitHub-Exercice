//
//  UserListView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import SwiftUI

struct UserListView: View {
    
    //ici on lit la variable observer dans les vues enfants via le @EnvironmentObjet
    @EnvironmentObject var userRequest: UserAPIRequest
    
    var body: some View {
        NavigationStack {
            LazyVStack {
                ForEach(userRequest.allUser) { user in
                    NavigationLink(destination: UserDetail(user: user), label: {
                        Text(user.name)
                    })
                   
                }
            }
        }
    }
}

struct UserDetail: View {
    
    @EnvironmentObject var drinkRequest: DrinkAPIRequestViewModel
    
    var user: User
    
    var body: some View {
        VStack {
            Text(user.name)
            
            ForEach(drinkRequest.allDrink.filter{ $0.id == user.idFromDrink.first }) { drink in
                HStack {
                    if let imageFound = drink.image.first {
                        AsyncImage(url: URL(string: imageFound.url)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                            } else if phase.error != nil {
//                                    Text("Image indisponible")
                                Image(systemName: "mug.full")
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    VStack {
                        Text(drink.name)
                        Text("\(drink.price) €")
                    }
                }
              
                
            }
        }
        
        
    }
}

#Preview {
    UserListView()
    
}
