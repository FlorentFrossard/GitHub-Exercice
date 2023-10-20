//
//  OptionalValuesIfLet.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 20/10/2023.
//

import SwiftUI

struct OptionalValuesIfLet: View {
    
    @State private var itemInUserCart = 0
    @State private var selectedItem: Int? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Items in cart: \(itemInUserCart)")
            
            Button("Add to cart") {
                
                //OPTIONAL BINDING
                //IF LET
                //si selectedItem a une donnée non optionnel alors on stock l'information dans une nouvelle constante
                //ici toto n'est utilisable que dans le block if
                //à l'extérieur toto n'existe pas!
                //sinon on passe dans le else
                if let toto = selectedItem {
                    itemInUserCart += toto
                    print(toto)
                } else {
                    print("No data found")
                }
                
            }
            .padding()
            .foregroundColor(.black)
            .bold()
            .background(.mint)
            .cornerRadius(20)
            
            //vous pouvez aussi utiliser le if let pour construire vos vue en faisant attention aux optionnels
            //si j'ai une donnée (donc != nil) alors je l'affiche dans mon text
            //sinon je passe dans le else à affiche une autre information
            if let toto = selectedItem {
                Text("You just added: \(toto) item!")
            } else {
                Text("No added item")
            }
            
        }
        .onAppear {
            //n'hésitez pas à me mettre en commentaire pour tester !
            selectedItem = 5
        }
    }
}

#Preview {
    OptionalValuesIfLet()
}
