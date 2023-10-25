//
//  ImageModel.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import Foundation

//MARK: TOUTES MES IMAGES PROVIENNENT DE MA BDD ET UTILISE LE TYPE
// /!\pensez bien à changer le nom de cette structure sinon elle va s'appeler comme celle de SwiftUI /!\
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
