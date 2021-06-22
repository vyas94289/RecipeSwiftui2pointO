//
//  AddButtonStyle.swift
//  RecipeSwiftUI
//
//  Created by Gaurang Vyas on 06/02/21.
//  Copyright © 2021 Gaurang Vyas. All rights reserved.
//

import SwiftUI

struct AddButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.gray)
            .font(.footnote)
            .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
            .background(Capsule().stroke(Color.gray, lineWidth: 1))
    }
}

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Rectangle().fill(Color.white))
            .cornerRadius(10)
            .shadow(color: .gray, radius: 2, x: 1, y: 1)
    }
}

struct OrangeButtonStyle: ButtonStyle {
    var width: CGFloat
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .frame(height: 50)
            .frame(maxWidth: width)
            .background(RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(configuration.isPressed ? Color.primaryClr
                                                .opacity(0.75) : Color.primaryClr))
            .scaleEffect(configuration.isPressed ? CGFloat(0.85) : 1.0)
            .animation(Animation.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1))
    }
}

extension Button {
    func orangeButtonStyle() -> some View {
        self.buttonStyle(OrangeButtonStyle(width: .infinity))
    }
}

