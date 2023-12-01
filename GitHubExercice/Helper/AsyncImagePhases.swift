//
//  AsyncImagePhases.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 01/12/2023.
//

import SwiftUI

struct AsyncImagePhases: View {
    
    let unwrappedImage: DataBaseImage
    let widthFrame: CGFloat
    let heightFrame: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: unwrappedImage.url)) { phase in
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
        .frame(width: widthFrame, height: heightFrame)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
