//
//  IngredientsView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 15/02/21.
//
 
import SwiftUI

struct IngredientsView: View {
    var ingredients: [Ingredient]
    @Binding var selections: [Int]
    var body: some View {
        Form {
            ForEach(ingredients) { ingredient in
                IngredientSelectionRow(ingredient: ingredient, isSelected: self.selections.contains(ingredient.id)) {
                    if self.selections.contains(ingredient.id) {
                        self.selections.removeAll(where: { $0 == ingredient.id })
                    }
                    else {
                        self.selections.append(ingredient.id)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Ingredients"), displayMode: .inline)
    }
}

struct IngredientSelectionRow: View {
    var ingredient: Ingredient
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Image( ingredient.image)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .cornerRadius(6)
                Text(ingredient.name)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView(ingredients: Ingredient.all, selections: .constant([1]))
    }
}
