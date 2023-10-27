//
//  ConfettiView.swift
//  GitHubExercice
//
//  Created by test on 27/10/2023.
//


import SwiftUI

struct ConffetiView: View {
   
    var body: some View {
        ZStack {
           Text("Ouaiiiss!")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Gradient(colors: [Color.pink, Color.yellow]))
            Rectangle()
                .fill(.blue)
                .frame(width: 8, height: 10)
                .modifier(ParticleModifier())
            Rectangle()
                .fill(.red)
                .frame(width: 8, height: 10)
                .modifier(ParticleModifier())
                .offset(x:60, y:70)
                
         }
     }
}

#Preview {
    ConffetiView()
}
