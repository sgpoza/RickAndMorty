//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var service: APIService
    
    enum Tab {
        case characters
        case locations
        case episodes
    }
    
    var body: some View {
        CharacterList()
            .tabItem {
                Label("Characters", systemImage: "star")
            }
            .onAppear {
                service.getCharacters()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(APIService())
    }
}
