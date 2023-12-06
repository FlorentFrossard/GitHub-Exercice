//
//  DrinkDetailView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 01/11/2023.
//

import SwiftUI

struct DrinkDetailView: View {
    @EnvironmentObject var drinkRequest: DrinkAPIRequestViewModel
    @EnvironmentObject var userSession: User
    var id: String
    
    var body: some View {
        VStack {
            if let index = drinkRequest.allDrink.firstIndex(where: { $0.id == id }) {
            Text(drinkRequest.allDrink[index].name)
                .font(.largeTitle)
            
            if let imageFound = drinkRequest.allDrink[index].image.first {
                AsyncImagePhases(unwrappedImageURL: imageFound.url, widthFrame: 100, heightFrame: 100)
            }
            
            Text("Coût: \(drinkRequest.formatPrice(index: index)) €")
        }
        }
    }
}

#Preview {
    DrinkDetailView(id: "gzprjg")
        .environmentObject(DrinkAPIRequestViewModel())
}
