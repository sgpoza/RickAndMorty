//
//  CharacterDetail.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import SwiftUI

struct CharacterDetail: View {
    @StateObject var service: APIService = APIService()
    var character: Character
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .lineLimit(2)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(character.status.rawValue) - \(character.species)")
                    .font(.title2)
                    .padding(.bottom)
                
                DataLine(title: "Gender", data: character.gender.rawValue)
                DataLine(title: "Origin", data: character.origin.name)
                DataLine(title: "Last known location", data: character.location.name)
                if let episode = service.characterFirstEpisode {
                    DataLine(title: "First seen in", data: episode.name)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .onAppear {
            service.getEpisode(url: character.episode[0])
        }
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var character : Character = JSONHelper().load("characterData.json")
    
    static var previews: some View {
        CharacterDetail(character: character)
            .environmentObject(APIService())
    }
}
