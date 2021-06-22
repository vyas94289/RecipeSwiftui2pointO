//
//  Ingredient.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 13/02/21.
//

import Foundation
import UIKit

struct Ingredient: Identifiable {
    let id: Int
    let name: String
    let image: String
    
    static let all: [Ingredient] = [.init(id: 1, name: "Butter", image: "ig_Butter"),
                                    .init(id: 2, name: "Strawberry", image: "ig_Strawberry"),
                                    .init(id: 3, name: "Water", image: "ig_Water"),
                                    .init(id: 4, name: "Eggs", image: "ig_Eggs"),
                                    .init(id: 5, name: "Flour", image: "ig_Flour"),
                                    .init(id: 6, name: "Graps", image: "ig_graps"),
                                    .init(id: 7, name: "Red Chilli", image: "red-chilli"),
                                    .init(id: 8, name: "Milk", image: "milk"),
                                    .init(id: 9, name: "Tomatoes", image: "tomatoes")]
    
}
