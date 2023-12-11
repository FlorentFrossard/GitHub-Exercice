//
//  DrinkDetailView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 01/11/2023.
//

import SwiftUI

struct DrinkDetailView: View {
    @EnvironmentObject var dataController: DataControllerViewModel
    @EnvironmentObject var userSession: User
    var id: String
    
    var body: some View {
        VStack {
            if let index = dataController.allDrinks.firstIndex(where: { $0.id == id }) {
            Text(dataController.allDrinks[index].name)
                .font(.largeTitle)
            
            if let imageFound = dataController.allDrinks[index].image.first {
                AsyncImagePhases(unwrappedImageURL: imageFound.url, widthFrame: 100, heightFrame: 100)
            }
            
            Text("Coût: \(dataController.formatPrice(index: index)) €")
        }
        }
    }
}

#Preview {
    DrinkDetailView(id: "gzprjg")
        .environmentObject(DrinkAPIRequestViewModel())
}
