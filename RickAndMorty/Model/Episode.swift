//
//  Episode.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import Foundation

struct Episode: Hashable, Codable, Identifiable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
