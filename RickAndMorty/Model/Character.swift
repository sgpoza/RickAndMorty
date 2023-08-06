//
//  Character.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import Foundation
import SwiftUI

struct CharacterResponse: Decodable {
    let info: PageInfo
    let results: [Character]
}

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

enum Gender: String, Hashable, Decodable, CaseIterable, Identifiable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
    
    var id: String { self.rawValue }
}

struct LocationData: Hashable, Decodable {
    let name: String
    let url: String
}

enum Status: String, Hashable, Decodable, CaseIterable, Identifiable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var id: String { self.rawValue }
}
