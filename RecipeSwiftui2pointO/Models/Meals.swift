//
//  Meals.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 09/02/21.
//

import Foundation
import FirebaseDatabase

enum MealType: String {
    case breakfast = "1"
    case brunch = "2"
    case lunch = "3"
    case dinner = "4"
}

struct Meal: Identifiable {
    var id: String
    var name: String

    static var all: [Meal] {
        return [Meal(id: "1", name: "Breakfast"), Meal(id: "2", name: "Brunch"),
                Meal(id: "3", name: "Lunch"), Meal(id: "4", name: "Dinner")]
    }
}
