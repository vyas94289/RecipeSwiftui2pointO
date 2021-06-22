//
//  Color+Ext.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 06/02/21.
//

import SwiftUI

extension Color {
    static var primaryClr: Color {
        Color(red: 0.9607843137, green: 0.3529411765, blue: 0, opacity: 1)
    }
    
    static var tabClr: Color {
        Color(#colorLiteral(red: 0.2730398774, green: 0.3229064047, blue: 0.3787322938, alpha: 1))
    }
    
    static var darkBlue: Color {
        Color(#colorLiteral(red: 0.06385680288, green: 0.07773614675, blue: 0.1524173915, alpha: 1))
    }
}

struct Blur: UIViewRepresentable {
    let style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
