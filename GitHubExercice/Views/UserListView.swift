//
//  UserListView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import SwiftUI

struct UserListView: View {
    
    //ici on lit la variable observer dans les vues enfants via le @EnvironmentObjet pour pouvoir voir les changements
    @EnvironmentObject var dataController: DataControllerViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(dataController.allUsers) { user in
                        NavigationLink(destination: ProfileView(otherUser: user), label: {
                            HStack(alignment: .top) {
                                if let imageFound = user.image.first {
                                    AsyncImagePhases(unwrappedImageURL: imageFound.url, widthFrame: 100, heightFrame: 100)
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
//        .environmentObject(DrinkAPIRequestViewModel())
//        .environmentObject(UserAPIRequestViewModel())
    
}
