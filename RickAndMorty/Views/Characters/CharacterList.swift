//
//  CharacterList.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import SwiftUI

struct CharacterList: View {
    @EnvironmentObject var service: APIService
    @State private var showingFilters = false
    
    var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if (!service.characters.isEmpty) {
                    LazyVGrid(columns: columns) {
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
                } else if (service.loaded) {
                    if (service.pageInfo == nil) {
                        Text("Aw, geez, Morty! Looks like these darn characters just don't wanna load, ya know? It's like they're stuck in some interdimensional traffic or something! We gotta find a way to get 'em here, Morty! Time to put on our thinking caps and get schwifty with it!")
                    } else {
                        Text("Hey, Morty, you see that over there? There's, like, a complete void of characters, Morty! It's like they took a portal to another dimension or decided to take a vacation or something. We're just surrounded by nothingness here, Morty. I guess we'll have to go on another wild adventure to find 'em or, uh, maybe create some new ones ourselves! Get ready, Morty, because we're about to dive into the unknown!")
                    }
                }
            }
            .navigationTitle("Characters")
            .toolbar {
                Button("Filter") {
                    showingFilters = true
                }
            }
            .sheet(isPresented: $showingFilters) {
                FilterView()
                    .environmentObject(service)
                    .onDisappear {
                        showingFilters = false
                    }
            }
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    
    static var previews: some View {
        CharacterList()
            .environmentObject(APIService())
            .onAppear {
                APIService().getCharacters()
            }
    }
}
