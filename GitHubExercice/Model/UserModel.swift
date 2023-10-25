//
//  Data Model.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 17/10/2023.
//

import Foundation
import SwiftUI

//struct User: Identifiable {
//    var id = UUID()
//}

// MARK: - Request
struct UserRequest: Codable {
    let records: [UserRecord]
    let offset: String
}

// MARK: - Record
struct UserRecord: Codable {
    let id, createdTime: String
    let fields: User
}

// MARK: - USER
struct User: Codable {
    let name, status, id, notes: String
    let image: [DataBaseImage]
    let drink, idFromDrink: [String]

    enum CodingKeys: String, CodingKey {
        case name, status, id, notes, image
        case drink = "Drink"
        case idFromDrink = "id (from Drink)"
    }
}

// MARK: - Image
struct DataBaseImage: Codable {
    let id: String
    let width, height: Int
    let url: String
    let filename: String
    let size: Int
    let type: String
    let thumbnails: Thumbnails
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let small, large, full: Full
}

// MARK: - Full
struct Full: Codable {
    let url: String
    let width, height: Int
}
