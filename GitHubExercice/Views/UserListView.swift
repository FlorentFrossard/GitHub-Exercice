//
//  UserListView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import SwiftUI

struct UserListView: View {
    
    //ici on lit la variable observer dans les vues enfants via le @EnvironmentObjet pour pouvoir voir les changements
    @EnvironmentObject var userRequest: UserAPIRequestViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    
                    ForEach(userRequest.allUser) { user in
                        NavigationLink(destination: ProfileView(user: user), label: {
                            
                            HStack(alignment: .top) {
                                if let imageFound = user.image.first {
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
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    
                                }
                                
                                
                                VStack {
                                    Text(user.name)
                                        .font(.title2)
                                        .bold()
                                        .foregroundStyle(Color.black)
                                    
                                }
                            }
                            
                            
                        })
                        
                    }
                }
            }
            .padding()
            .navigationTitle("Vos connexions")
        }
    }
}


#Preview {
    UserListView()
        .environmentObject(DrinkAPIRequestViewModel())
        .environmentObject(UserAPIRequestViewModel())
    
}
