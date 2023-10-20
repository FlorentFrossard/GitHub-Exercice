//
//  OptionalValues.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 20/10/2023.
//

import SwiftUI

//MARK: OPTIONAL
//une boite dont on ne connait pas le contenu
//lorsque l'on ouvre cette boite on dis que se fait "unwrap" ou "déballer"
//comme un cadeau magique (empoisonné?) qu'on déballe

struct OptionalValues: View {
    
    //Type? -> Type optionnel
    //nil -> absence de valeur
    @State private var itemInUserCart = 0
    @State private var selectedItem: Int? = nil
    
    var userImage: String?
    
    var body: some View {
        
        VStack {
            //COALESCENCE
            //dans le cas où je n'ai pas d'image
            //J'affiche une image à défaut après les ??
            //ici "bolt.fill"
            Image(systemName: userImage ?? "person.fill")
                .font(.largeTitle)
                .foregroundColor(.brown)
            
            Text("Items in cart: \(itemInUserCart)")
            
            Button("Add to cart") {
                //FORCE UNWRAP - BANG & NIL
                //si selectItem à bien une valeur différent de nil
                //on peut incrémenter cette valeur dans ItemInUserCart
                //sinon on peut faire autre chose
                //cette méthode fonctionne avec l'opérateur bang -> !
                //sans lui la valeur reste optionnel
                if selectedItem != nil {
                    itemInUserCart += selectedItem!
                }
            }
            .padding()
            .foregroundColor(.black)
            .bold()
            .background(.yellow)
            .cornerRadius(20)
        }
        .onAppear {
            //n'hésitez pas à me mettre en commentaire pour tester !
            selectedItem = 2
        }
    }
}

#Preview {
    OptionalValues()
}
