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
// /!\ RIEN NE VOUS FORCE A METTRE CETTE STRUCT EN CLASS, C'EST FAIT A TITRE D'EXEMPLE
// /!\ VOUS POUVEZ POUVEZ OBSERVER UN SEUL UTILISATEUR SI BESOIN

//on observer les changement des variables mis en Published
//le ObservableObject indique qu'on va devenir des stalker
//le @Published est la victime ;D

//oubliez pas de rendre votre donnée finale (celle que vous voulez utiliser et travailler) Identifiable pour SwiftUI
class User: Codable, Identifiable, ObservableObject {
    @Published var name: String
    @Published var status: String
    @Published var id: String
    @Published var notes: String
    
    //si vous utilisez des attachements sur Airtable toutes vos images vont venir de la même manière
    //donc on utilise un type global d'image, ici DataBaseImage que ce soit utiliser partout et éviter d'avoir 3-4 structures d'images différentes
    //alors que la donnée  reçu reste la même
    @Published var image: [DataBaseImage]
    @Published var idFromDrink: [String]
    @Published var drink: [String]
    
    //si on souhaite faire une connexion un Bool qui change en fonction de l'action est utile
    //on le met ici au cas où, si il n'est pas utile, on l'enlèvera
    @Published var loggedIn: Bool?
    
    //ce truc là c'est pour nous aider a coder et decoder
    //ça communique les infos envoyer avec ce style pour se conformer au attentes de Airtable
    enum CodingKeys: String, CodingKey {
        case name, status, id, notes, image
        case drink = "Drink"
        case idFromDrink = "id (from Drink)"
    }
    
    //vue qu'on est maintenant dans une class on doit init (mettre prêt à l'emploi) les propriétés de class
    init(id: String, name: String, status: String, notes: String, image: [DataBaseImage], drink: [String], idFromDrink: [String]) {
        self.id = id
        self.name = name
        self.status = status
        self.notes = notes
        self.image = image
        self.drink = drink
        self.idFromDrink = idFromDrink
    }
    
    //ensuite on leur explique comment elles vont être décodées
    //en utilisant l'enum de CodingKeys on va lui dire quoi décoder
    //il faut comprendre à quoi correspondent ces CodingKeys, pour cela il faut le JSON de votre data
    //chacun de ces keys correspond a une propriété dans votre table Airtable
    //et on donne l'info au décoder.container
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //ensuite on décode chaque propriété en fonction de sa CodingKey et de son type
        self.idFromDrink = try container.decode([String].self, forKey: .idFromDrink)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(String.self, forKey: .status)
        self.id = try container.decode(String.self, forKey: .id)
        self.notes = try container.decode(String.self, forKey: .notes)
        self.image = try container.decode([DataBaseImage].self, forKey: .image)
        self.drink = try container.decode([String].self, forKey: .drink)
    }
    
    //Le principle pour encoder est le même, on utilise les CodingKeys pour ciblé la bonne propriété
    //et on lui comment encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idFromDrink, forKey: .idFromDrink)
        try container.encode(name, forKey: .name)
        try container.encode(status, forKey: .status)
        try container.encode(id, forKey: .id)
        try container.encode(notes, forKey: .notes)
        try container.encode(image, forKey: .image)
        try container.encode(drink, forKey: .drink)
    }
    
}


