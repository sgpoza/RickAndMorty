//
//  APIService.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import Foundation

class APIService: ObservableObject {
    
    private var baseUrl = "https://rickandmortyapi.com/api/"
    
    @Published var characters: [Character] = []
    @Published var pageInfo: PageInfo? = nil
    
    @Published var characterFirstEpisode: Episode? = nil
    
    func getCharacters() {
        getRequest(url: "\(baseUrl)character", type: CharacterResponse.self) { result in
            self.pageInfo = result.info
            self.characters = result.results
        }
    }
    
    func addNextCharacterPage() {
        if let nextPageUrl = pageInfo?.next {
            getRequest(url: nextPageUrl, type: CharacterResponse.self) { result in
                self.pageInfo = result.info
                self.characters += result.results
            }
        }
        
        
    }
    
    func getEpisode(url: String) {
        getRequest(url: url, type: Episode.self) { result in
            self.characterFirstEpisode = result
        }
    }
    
    private func getRequest<T: Decodable>(url: String, type: T.Type, completion: @escaping (T)/*Result<T, Error>*/ -> Void) {
        guard let url = URL(string: url) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(result)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
}
