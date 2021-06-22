//
//  HomeScreenView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 09/02/21.
//

import SwiftUI
import Combine
import FirebaseAuth
struct HomeScreenView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @Binding var dismiss: Bool
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(session.recipes, id: \.id) { value in
                        NavigationLink(destination: RecipeDetails(recipe: value)) {
                            RecipeCellView(recipe: value)
                        }
                    }
                }.padding()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitle(Text("What would you like to cook today?"), displayMode: .inline)
            .navigationBarItems(trailing: Button("Close", action: {
               // self.dismiss = true
                session.logOut()
            }))
        }
    }
}

struct RecipeCellView: View {
    var recipe: RecipeInfo
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            URLImage(urlString: recipe.image,
                     placeholder: Image("recipe_placholder")
                        .resizable()
                        .eraseToAnyView())
               
                .aspectRatio(1, contentMode: .fit)
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.mealTypeString).font(.caption).foregroundColor(.blue)
                Text(recipe.recipeName)
                HStack {
                    RatingView(rating: .constant(3))
                    Text("\(recipe.calories) Calories").foregroundColor(.primaryClr).font(.caption)
                }
                HStack(spacing:  16) {
                    IconLabelView(image: UIImage(systemName: "clock")!,
                                  title: Helper.minutesToHoursAndMinutesString(recipe.timeInMinutes))
                    IconLabelView(image: UIImage(named: "ic_serving")!, title: "\(recipe.numberOfServes) Serving")
                }.foregroundColor(Color.gray).frame(height: 12)
                
            }
           Spacer()
        }
        
        .frame(height: 90, alignment: .center)
        .background(Color(UIColor.systemGray4))
        .cornerRadius(16)
    }
}
