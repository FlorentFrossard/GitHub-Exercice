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
                AsyncImage(url: URL(string: imageFound.url)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Image(systemName: "mug.full")
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
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
