//
//  PageInfo.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 6/8/23.
//

import Foundation

struct PageInfo: Decodable {
    let count, pages: Int
    let next: String?
    let prev: String?
}
