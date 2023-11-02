//
//  Favorite+CoreDataProperties.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 02/11/2023.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: String?
    @NSManaged public var image: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var price: Double
    
    var wrappedId: String {
        id ?? "Id introuvable"
    }
    
    var wrappedImage: String {
        image ?? "Image introuvable"
    }
    
    var wrappedUser: String {
        user ?? "Utilisateur introuvable"
    }
    
    var wrappedName: String {
        name ?? "Nom introuvable"
    }

}

extension Favorite : Identifiable {

}
