//
//  PhotoFilterViewModel.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 19/02/21.
//

import Combine
import Foundation

struct PhotoFilter {
    var imageType, category, color, order: String
    var perPage: Double
    
    static let defaultFilter = PhotoFilter(imageType: "all", category: "backgrounds", color: "all", order: "popular", perPage: 40)
    
    func getURL(page: Int) -> URL? {
        //"https://pixabay.com/api/?key=17933757-927badc7ac574370ac49d7875&q=yellow+flowers&image_type=photo&pretty=true")
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pixabay.com"
        urlComponents.path = "/api/"
        var queryItems = [
            URLQueryItem(name: "key", value: "17933757-927badc7ac574370ac49d7875"),
            URLQueryItem(name: "image_type", value: imageType),
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "per_page", value: String(Int(perPage))),
            URLQueryItem(name: "page", value: String(page))
        ]
        if color != "all" {
            queryItems.append(URLQueryItem(name: "colors", value: color))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}

class PhotosFilterViewModel: ObservableObject {
    let allPhotoType = ["all", "photo", "illustration", "vector"]
    let allCategory = ["backgrounds", "fashion", "nature", "science", "education", "feelings", "health", "people", "religion", "places", "animals", "industry", "computer", "food", "sports", "transportation", "travel", "buildings", "business", "music"]
    let allColors = ["all", "grayscale", "transparent", "red", "orange", "yellow", "green", "turquoise", "blue", "lilac", "pink", "white", "gray", "black", "brown"]
    let allOrders = ["popular", "latest"]
    @Published var photoType = "all"
    @Published var category = "backgrounds"
    @Published var color = "all"
    @Published var order = "popular"
    @Published var perPage: Double = 20
    
    var filter: PhotoFilter {
        PhotoFilter(imageType: photoType, category: category,
                    color: color, order: order, perPage: perPage)
    }
}
