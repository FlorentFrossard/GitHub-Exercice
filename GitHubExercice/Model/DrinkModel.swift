//
//  DrinkModel.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import Foundation
import SwiftUI

//MARK: VOUS ALLEZ DEVOIR RETRAVAILLER VOS STRUCTURES AVANT DE POUVOIR LES UTILISER

// MARK: - Request
//changer le nom de la requête !
//1 requête = 1 type de donnée pull
struct DrinkRequest: Codable {
    let records: [DrinkRecord]
//    let offset: String
}

// MARK: - Record
//de même pour le record
//1 record = 1 type de donnée pull
struct DrinkRecord: Codable {
    let id, createdTime: String
    let fields: Drink
}

// MARK: - Fields
//oubliez pas de rendre votre donnée finale (celle que vous voulez utiliser et travailler) Identifiable pour SwiftUI
struct Drink: Codable, Identifiable {
    let favorite, id: String
    let price: Double
    let name: String
    //si vous utilisez des attachements sur Airtable toutes vos images vont venir de la même manière
    //donc on utilise un type global d'image, ici DataBaseImage que ce soit utiliser partout et éviter d'avoir 3-4 structures d'images différentes
    //alors que la donnée  reçu reste la même
    let image: [DataBaseImage]
    let user: [String]

    //ce truc là c'est pour nous aider a coder et decoder
    //ça communique les infos envoyer avec ce style pour se conformer au attentes de Airtable
    enum CodingKeys: String, CodingKey {
        case favorite, id, price, name, image
        case user = "User"
    }
}














