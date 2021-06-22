//
//  DeboundViewModel.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 22/02/21.
//

import Foundation
import Combine
import Foundation
import SwiftUI

class DeboundViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var search: String = "game"
    private var bag = Set<AnyCancellable>()
    
    init() {
        
        $search.debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .sink { (str) in
                self.getDataSearch()
                print(str)
            }.store(in: &bag)
    }
    
    func getDataSearch() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "imdb8.p.rapidapi.com"
        urlComponents.path = "/auto-complete"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: search)]
        guard let url = urlComponents.url else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("fxpS8R97a7mshT1cLYfZf5OR0wCtp1R8Ytgjsn7MvPcEo1F3JF", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("imdb8.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: Movies.self, decoder: JSONDecoder())
            .map({$0.d})
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .assign(to: \.movies, on: self)
            .store(in: &bag)
    }
    
}
