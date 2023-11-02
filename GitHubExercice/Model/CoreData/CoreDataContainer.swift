//
//  CoreDataContainer.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 02/11/2023.
//

import Foundation
import CoreData

class CoreDataContainer: ObservableObject {
    //on créer un container pour enregistrer notre donnée dedans
    //il doit porter le même nom que notre Data Model
    let container = NSPersistentContainer(name: "AppDataModel")
    
    
    
    init() {
        //on init le container afin qu'il soit prêt à l'emploi dès le lancement de l'app
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data n'a pas pu s'initialiser \(error.localizedDescription)")
            }
        }
        //et ici on lui dit comment gérer la contrainte sur les doublons ID
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
}
