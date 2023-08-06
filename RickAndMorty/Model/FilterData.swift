//
//  FilterData.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 6/8/23.
//

import Foundation

class FilterData {
    
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    
    init() {
        self.name = ""
        self.status = ""
        self.species = ""
        self.type = ""
        self.gender = ""
    }
    
    init(name: String, status: String, species: String, type: String, gender: String) {
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
    }
}
