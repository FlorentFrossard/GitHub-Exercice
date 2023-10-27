//
//  DrinkListView.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 27/10/2023.
//

import SwiftUI

struct DrinkListView: View {
    
    @EnvironmentObject var drinkRequest: DrinkAPIRequestViewModel
    
    var body: some View {
        NavigationStack {
            LazyVStack(alignment: .leading) {
                ForEach(drinkRequest.allDrink) { drink in
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
                        
                        Text(drink.name)
                    }
                   
                }
            }
        }
    }
}

#Preview {
    DrinkListView()
}
