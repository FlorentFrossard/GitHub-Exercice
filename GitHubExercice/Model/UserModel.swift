//
//  Data Model.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 17/10/2023.
//

import Foundation
import SwiftUI

//MARK: VOUS ALLEZ DEVOIR RETRAVAILLER VOS STRUCTURES AVANT DE POUVOIR LES UTILISER

// MARK: - Request
//changer le nom de la requête !
//1 requête = 1 type de donnée pull
struct UserRequest: Codable {
    let records: [UserRecord]
//    let offset: String
}

// MARK: - Record
//de même pour le record
//1 record = 1 type de donnée pull
struct UserRecord: Codable {
    let id, createdTime: String
    let fields: User
}

// MARK: - USER 
//oubliez pas de rendre votre donnée finale (celle que vous voulez utiliser et travailler) Identifiable pour SwiftUI
struct User: Codable, Identifiable {
    let name, status, id, notes: String
    //si vous utilisez des attachements sur Airtable toutes vos images vont venir de la même manière
    //donc on utilise un type global d'image, ici DataBaseImage que ce soit utiliser partout et éviter d'avoir 3-4 structures d'images différentes
    //alors que la donnée  reçu reste la même
    let image: [DataBaseImage]
    let drink, idFromDrink: [String]

    //ce truc là c'est pour nous aider a coder et decoder
    //ça communique les infos envoyer avec ce style pour se conformer au attentes de Airtable
    enum CodingKeys: String, CodingKey {
        case name, status, id, notes, image
        case drink = "Drink"
        case idFromDrink = "id (from Drink)"
    }
}


