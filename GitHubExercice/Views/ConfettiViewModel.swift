//
//  ConfettiViewModel.swift
//  GitHubExercice
//
//  Created by test on 27/10/2023.
//

import Foundation
import SwiftUI

struct FireworkParticleGeometryEffect: GeometryEffect {
    
    var time: Double
    var speed = Double.random(in: 30...200)
    var direction = Double.random(in: -Double.pi ... Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue}
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslationn = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affinedTranslation = CGAffineTransform(translationX: xTranslationn, y: yTranslation)
        return ProjectionTransform(affinedTranslation)
    }
}

struct ParticleModifier: ViewModifier {
   
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<100, id:\.self) { index in
                    content
                    .hueRotation(Angle(degrees: time * 90))
                    .scaleEffect(scale)
                    .modifier(FireworkParticleGeometryEffect(time: time))
                    .opacity((duration-time) / duration)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: duration).delay(0.5)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}


