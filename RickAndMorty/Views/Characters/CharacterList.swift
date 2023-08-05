//
//  CharacterList.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import SwiftUI

struct CharacterList: View {
    @EnvironmentObject var service: APIService
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(service.characters) { character in
                        NavigationLink {
                            CharacterDetail(character: character)
                                .environmentObject(APIService())
                        } label: {
                            CharacterRow(character: character)
                        }
                        .onAppear {
                            if character.id == service.characters.last?.id {
                                service.addNextCharacterPage()
                            }
                        }
                    }
                    .id(service.characters.last?.id)
                }
            }
            .navigationTitle("Characters")
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    var service: APIService = APIService()
    
    static var previews: some View {
        CharacterList()
            .environmentObject(APIService())
            .onAppear {
                APIService().getCharacters()
            }
    }
}
