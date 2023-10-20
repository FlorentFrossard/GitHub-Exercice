//
//  ContentView.swift
//  GitHubExercice
//
//  Created by test on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "1.circle")
                .resizable()
                .scaledToFit()
            Text("Version 10.0")
                .font(.largeTitle)
                .fontWeight(.black)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
