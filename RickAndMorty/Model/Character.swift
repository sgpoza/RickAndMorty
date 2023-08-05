//
//  Character.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import Foundation
import SwiftUI

// MARK: - CharacterResponse
struct CharacterResponse: Decodable {
    let info: PageInfo
    let results: [Character]
}

struct PageInfo: Decodable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Character
struct Character: Hashable, Decodable, Identifiable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: LocationData
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Hashable, Decodable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct LocationData: Hashable, Decodable {
    let name: String
    let url: String
}

enum Status: String, Hashable, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
