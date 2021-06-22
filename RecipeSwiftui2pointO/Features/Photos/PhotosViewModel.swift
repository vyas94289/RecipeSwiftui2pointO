//
//  PhotosViewModel.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 18/02/21.
//

import Combine
import Foundation

class PhotosViewModel: ObservableObject {
    var filterPublisher = CurrentValueSubject<PhotoFilter, Never>(.defaultFilter)
    @Published private(set) var state: State
    private var bag = Set<AnyCancellable>()
    @Published var photos: [Hit] = []
    @Published var page: Int = 0
    @Published var hasMoreData = true
    @Published var showLoading = true
    @Published var searchText: String = ""
    var totalHits: Int = 0
    init() {
        state = .idle
        filterPublisher.sink { (filter) in
            self.page = 0
            self.getData(filter)
        }.store(in: &bag)
    }
    
    func send(event: Event) {
        switch event {
        case .onAppear:
            getData(PhotoFilter.defaultFilter)
        case .onLoaded(let photos):
            if self.page == 1 {
                self.photos = photos
            } else {
                self.photos += photos
            }
            hasMoreData = photos.count < totalHits
            self.state = .loaded(self.photos)
        case .onFailedToLoad(let error):
            self.state = .error(error)
        }
    }
    
    func getData(_ filter: PhotoFilter) {
        page += 1
        guard let url = filter.getURL(page: page) else {
            return
        }
        if page == 1 {
            state = .loading
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Photos.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            }, receiveValue: { photos in
                self.totalHits = photos.total
                self.send(event: .onLoaded(photos.hits))
                
            }).store(in: &bag)
    }
}

extension PhotosViewModel {
    enum State {
        case idle
        case loading
        case loaded([Hit])
        case error(String)
    }
    
    enum Event {
        case onAppear
        case onLoaded([Hit])
        case onFailedToLoad(String)
    }
}
