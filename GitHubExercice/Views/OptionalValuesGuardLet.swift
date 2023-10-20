//
//  OptionalValuesGuardLet.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 20/10/2023.
//

import SwiftUI

struct OptionalValuesGuardLet: View {
    
    @State private var itemInUserCart = 0
    @State private var selectedItem: Int? = nil
    
    var body: some View {
        VStack {
            Text("Items in cart: \(itemInUserCart)")
            
            
            Button("Add to cart") {
                //GUARD LET
                //ça déballe aussi un optionnel mais l'écriture n'est pas la même
                //on se focalise plus sur la partie réussite qu'échec
                //si de la donnée existe alors on stock l'info dans une nouvelle constant
                //la constant doit être utiliser après ce guard let et non dans ces accolades
                
                //sinon on rentre de le else
                //lorsque l'on passe dans le else le guard let arrête tout autre ligne de code qui suive ce block conditionnel
                //exemple:
                //si selectedItem == nil alors le code à partir de la ligne 39 ne sera pas exécuté
                
                print("OUF je suis avant le guard donc je serais lu dans tous les cas!")
                
                guard let lala = selectedItem else {
                    print("no data")
                    return
                }
                //si j'ai une valeur != nil alors le code continue de s'exécuter après le block conditionnel!
                itemInUserCart += lala
                print(lala)
                print("Beep Boop")
            }
            .padding()
            .foregroundColor(.black)
            .bold()
            .background(.pink)
            .cornerRadius(20)
        }
        .onAppear {
            //n'hésitez pas à me mettre en commentaire pour tester !
            selectedItem = 10
        }
    }
}

#Preview {
    OptionalValuesGuardLet()
}
