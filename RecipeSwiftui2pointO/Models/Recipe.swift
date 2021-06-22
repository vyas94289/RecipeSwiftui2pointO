//
//  Recipe.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 16/02/21.
//

import Foundation
import FirebaseDatabase

class RecipeInfo: Codable {

    var id = UUID()
    var image: String
    var recipeName: String
    var calories: Int
    var mealType: String
    var courseType: String
    var numberOfServes: Int
    var timeInMinutes: Int
    var selectedIngredients: [Int]
    var directions: [String]
    var mealTypeString: String {
        return Meal.all.first(where: {$0.id == mealType})?.name ?? ""
    }
    
    init(image: String, recipeName: String, calories: Int,
         mealType: String, courseType: String, numberOfServes: Int,
         timeInMinutes: Int, selectedIngredients: [Int], directions: [String]) {
        self.image = image
        self.recipeName = recipeName
        self.calories = calories
        self.mealType = mealType
        self.courseType = courseType
        self.numberOfServes = numberOfServes
        self.timeInMinutes = timeInMinutes
        self.selectedIngredients = selectedIngredients
        self.directions = directions
    }
    
    var dictionaryData: [String: Any] {
        return ["image": image, "recipeName": recipeName,
                "calories": calories, "mealType": mealType,
                "courseType": courseType, "numberOfServes": numberOfServes,
                "timeInMinutes": timeInMinutes, "selectedIngredients": selectedIngredients,
                "directions": directions]
    }
    
    static func getRecipeList(_ snapshot: DataSnapshot) -> [RecipeInfo] {
        var array: [RecipeInfo] = []
        for child in snapshot.children {
            if let snapshot = child as? DataSnapshot {
                guard let values = snapshot.value as? [String: Any],
                      let recipe = getRecipe(from: values) else {
                    continue
                }
                array.append(recipe)
            }
        }
        return array
    }
    
    static func getRecipe(from dictionary: [String: Any]) -> RecipeInfo? {
        do {
            var dict = dictionary
            dict["id"] = UUID().uuidString
            let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            return try JSONDecoder().decode(RecipeInfo.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
