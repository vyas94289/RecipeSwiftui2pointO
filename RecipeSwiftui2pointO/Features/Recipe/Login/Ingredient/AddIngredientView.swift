//
//  AddIngredientView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 06/02/21.
//

import SwiftUI

struct AddIngredientView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var title: String
    @State var value: String = ""
    var saved: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(title)) {
                    TextField(title, text: $value)
                }
            }
            .navigationTitle("Add New Ingredient").navigationBarItems(trailing: Button("Save", action: {
                saved(value)
                presentationMode.wrappedValue.dismiss()
            }))
        }
        
    }
}
