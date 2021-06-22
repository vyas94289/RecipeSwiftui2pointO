//
//  Movies.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 22/02/21.
//

import Foundation
struct Movies: Codable {
    let d: [Movie]
    let q: String
    let v: Int
}

struct Movie: Codable {
    let i: I
    let id, l, q: String
    let rank: Int
    let s: String
    let v: [V]?
    let vt: Int?
    let y: Int
    let yr: String?
}

struct I: Codable {
    let height: Int
    let imageURL: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height
        case imageURL = "imageUrl"
        case width
    }
}

struct V: Codable {
    let i: I
    let id, l, s: String
}
