//
//  LoadingButton.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 09/02/21.
//

import SwiftUI

struct LoadingButton: View {
    @Binding var isLoading: Bool
    var title: String
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            VStack {
                if isLoading {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                } else {
                    Text(title)
                }
            }
            .foregroundColor(Color.white)
            .frame(height: 50)
                .frame(maxWidth: isLoading ? 50 : .infinity)
                .background(Capsule().fill(Color.primaryClr))
            .animation(Animation.spring(response: 0.35, dampingFraction: 0.75, blendDuration: 1))
        }).disabled(isLoading)
    }
}

