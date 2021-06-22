//
//  IconLabelView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 17/02/21.
//

import SwiftUI

struct IconLabelView: View {
    let image: UIImage
    let title: String
    var body: some View {
        HStack(spacing: 4) {
            Image(uiImage: image.withRenderingMode(.alwaysTemplate))
                .resizable()
                .aspectRatio(1, contentMode: .fit)
            Text(title).font(.caption)
        }
    }
}
