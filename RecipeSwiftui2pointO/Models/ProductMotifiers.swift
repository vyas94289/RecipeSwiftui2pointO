//
//  ProductMotifiers.swift
//  RecipeSwiftUI
//
//  Created by Gaurang Vyas on 05/02/21.
//  Copyright © 2021 Gaurang Vyas. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

enum ItemType: String {
    case milk = "Milk"
    case size = "Size"
    case temp = "Temp"
    case espresso = "Espresso"
    case sugar = "Sugar"
}

class Ingredient: Identifiable, ObservableObject {
    var id: Int
    var name: String
    var selected: Bool = false
    var value: String = ""
    
    init(id: Int, title: String) {
        self.id = id
        self.name = title
    }
    
    convenience init(dict: [String: Any]) {
        let id = dict["id"] as! Int
        let name = dict["name"] as! String
        self.init(id: id, title: name)
    }
    
    static func getArray(from arrayDict: [[String: Any]]) -> [Ingredient] {
        var array: [Ingredient] = []
        for row in arrayDict {
            array.append(.init(dict: row))
        }
        return array
    }
}

class ItemModel: Identifiable {
    let type: ItemType
    var ingredient: [Ingredient] = []
    var showPopUp: Bool = false
    
    init(name: String, ingredient: [Ingredient]) {
        self.type = ItemType(rawValue: name) ?? .size
        self.ingredient = ingredient
    }
    
    static func dummyData() -> [ItemModel] {
        guard let data = jsonString.data(using: .utf8) else {
            return []
        }
        do {
            guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return []
            }
            var array: [ItemModel] = []
            dict.forEach { key, value in
                guard let ingredientData = (value as? [String: Any])?["ingredient"] as? [[String: Any]] else {
                    return
                }
                array.append(.init(name: key, ingredient: Ingredient.getArray(from: ingredientData)))
            }
            return array
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}




let jsonString = """
{
"Milk": {
"ingredient": [
{
"id": 1,
"type": "Milk",
"name": "Skim Milk"
},
{
"id": 2,
"type": "Milk",
"name": "1% Milk"
},
{
"id": 3,
"type": "Milk",
"name": "Almond Milk"
},
{
"id": 16,
"type": "Milk",
"name": "Merchant Verified Milk"
}
]
},
"Size": {
"ingredient": [
{
"id": 4,
"type": "Size",
"name": "6 oz"
},
{
"id": 5,
"type": "Size",
"name": "8 oz"
},
{
"id": 6,
"type": "Size",
"name": "10 oz"
}
]
},
"Temp": {
"ingredient": [
{
"id": 7,
"type": "Temp",
"name": "Temp 1"
},
{
"id": 8,
"type": "Temp",
"name": "Temp 2"
},
{
"id": 9,
"type": "Temp",
"name": "Temp 3"
}
]
},
"Espresso": {
"ingredient": [
{
"id": 10,
"type": "Espresso",
"name": "Single Origin"
},
{
"id": 11,
"type": "Espresso",
"name": "Organic"
},
{
"id": 12,
"type": "Espresso",
"name": "Weak"
}
]
},
"Sugar": {
"ingredient": [
{
"id": 13,
"type": "Sugar",
"name": "No Sugar"
},
{
"id": 14,
"type": "Sugar",
"name": "White Sugar"
},
{
"id": 15,
"type": "Sugar",
"name": "Honey"
}
]
}
}
"""
