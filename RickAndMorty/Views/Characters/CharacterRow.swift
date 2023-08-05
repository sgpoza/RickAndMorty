//
//  CharacterRow.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            
            Text(character.name)
                .font(.title2)
                .fontWeight(.medium)
            
            Spacer()
        }
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var character : Character = JSONHelper().load("characterData.json")
    
    static var previews: some View {
        Group {
            CharacterRow(character: character)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
