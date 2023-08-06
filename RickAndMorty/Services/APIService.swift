//
//  APIService.swift
//  RickAndMorty
//
//  Created by Sergio González Poza on 5/8/23.
//

import Foundation

class APIService: ObservableObject {
    
    private var baseUrl = "https://rickandmortyapi.com/api/"
    private var charactersUrl = "character"
    
    @Published var characters: [Character] = []
    @Published var pageInfo: PageInfo? = nil
    @Published var filters: FilterData = FilterData()
    
    @Published var characterFirstEpisode: Episode? = nil
    
    var loaded = false
    
    func getCharacters() {
        getRequest(url: "\(baseUrl)\(charactersUrl)", type: CharacterResponse.self) { result in
            self.loaded = true
            switch result {
            case .success(let data):
                self.pageInfo = data.info
                self.characters = data.results
            case .failure:
                DispatchQueue.main.async {
                    self.pageInfo = nil
                    self.characters = []
                }
            }
        }
    }
    
    func setFilters() {
        var filter = ""
        filter += getFilter(title: "name", value: filters.name, isFirstFilter: filter.isEmpty)
        filter += getFilter(title: "status", value: filters.status, isFirstFilter: filter.isEmpty)
        filter += getFilter(title: "species", value: filters.species, isFirstFilter: filter.isEmpty)
        filter += getFilter(title: "type", value: filters.type, isFirstFilter: filter.isEmpty)
        filter += getFilter(title: "gender", value: filters.gender, isFirstFilter: filter.isEmpty)
        charactersUrl = "character\(filter)"
    }
    
    func getFilter(title: String, value: String, isFirstFilter: Bool) -> String {
        return !value.isEmpty ? "\(isFirstFilter ? "/?" : "&")\(title)=\(value)" : ""
    }
    
    func addNextCharacterPage() {
        if let nextPageUrl = pageInfo?.next {
            getRequest(url: nextPageUrl, type: CharacterResponse.self) { result in
                switch result {
                case .success(let data):
                    self.pageInfo = data.info
                    self.characters += data.results
                case .failure:
                    DispatchQueue.main.async {
                        self.pageInfo = nil
                    }
                }
            }
        }
    }
    
    func getEpisode(url: String) {
        getRequest(url: url, type: Episode.self) { result in
            switch result {
            case .success(let data):
                self.characterFirstEpisode = data
            case .failure:
                self.characterFirstEpisode = nil
            }
            
        }
    }
    
    private func getRequest<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let responseData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(responseData))
                    } catch let error {
                        completion(.failure(error))
                    }
                }
            } else {
                completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: nil)))
            }
        }

        dataTask.resume()
    }
}
