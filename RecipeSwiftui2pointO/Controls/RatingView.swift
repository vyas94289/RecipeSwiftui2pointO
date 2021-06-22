//
//  RatingView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 17/02/21.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { value in
                if value > rating {
                    Image(systemName: "star")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                } else {
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                }
            }
        }
        .frame(height: 14).foregroundColor(.primaryClr)
    }
    
}
