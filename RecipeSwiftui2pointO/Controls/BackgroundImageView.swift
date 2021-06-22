//
//  BackgroundImageView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 07/02/21.
//

import SwiftUI

struct BackgroundImageView: View {
    let size: CGSize
    var body: some View {
        Image(Images.background)
            .resizable()
                 .aspectRatio(contentMode: .fill)
            .frame(alignment: .center)
                 .clipped()
            .overlay(LinearGradient(gradient: .init(colors: [Color.black.opacity(0.3), Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
    }
}
