//
//  GitHubExerciceApp.swift
//  GitHubExercice
//
//  Created by test on 10/10/2023.
//

import SwiftUI

@main
struct GitHubExerciceApp: App {
    @StateObject var coreDataContainer = CoreDataContainer()
    var body: some Scene {
        WindowGroup {
            RootView()
            //on init le context pour observer notre donnée et le container pour que les deux communique ensemble
                .environment(\.managedObjectContext, coreDataContainer.container.viewContext)
        }
    }
}
