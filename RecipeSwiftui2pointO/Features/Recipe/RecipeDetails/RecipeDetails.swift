//
//  RecipeDetails.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 17/02/21.
//

import SwiftUI

struct RecipeDetails: View {

    var recipe: RecipeInfo
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                mainContent.frame( maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                Spacer()
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    

    
    var mainContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(recipe.mealTypeString).font(.caption).foregroundColor(.blue)
            HStack {
                Text(recipe.recipeName).font(.title2).bold()
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "heart")
                }).foregroundColor(.gray)
            }
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("\(recipe.calories) Calories")
                        .foregroundColor(.primaryClr)
                        .font(.caption)
                    RatingView(rating: .constant(3))
                    IconLabelView(image: UIImage(systemName: "clock")!,
                                  title: Helper.minutesToHoursAndMinutesString(recipe.timeInMinutes))
                        .foregroundColor(Color.gray).frame(height: 12)
                    IconLabelView(image: UIImage(named: "ic_serving")!, title: "\(recipe.numberOfServes) Serving")
                        .foregroundColor(Color.gray).frame(height: 12)
                }
                Spacer()
                URLImage(urlString: recipe.image,
                         placeholder: Image("recipe_placholder")
                            .resizable()
                            .eraseToAnyView())
                    .frame(width: UIScreen.main.bounds.size.width / 2)
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(8)
                
            }
            
            VStack(alignment: .leading) {
                Text("Ingredients")
                ScrollView.init(.horizontal, showsIndicators: false, content: {
                    LazyHStack {
                        ForEach(Ingredient.all) { ingr  in
                            Image(ingr.image).resizable().aspectRatio(1, contentMode: .fit).background(Color.white).cornerRadius(8)
                        }
                    }
                }).frame(height: 50)
            }
            VStack(alignment: .leading) {
                Text("Directions")
                LazyVStack(spacing: 8) {
                    ForEach(recipe.directions, id: \.self) { value in
                        HStack(alignment: .top) {
                            Circle().fill(Color.primaryClr).frame(width: 8).fixedSize().padding(.top, 2)
                            Text(value).font(.caption).multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                }
            }
            
        }
    }
}

