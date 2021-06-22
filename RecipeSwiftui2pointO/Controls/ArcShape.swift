//
//  ArcShape.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 10/02/21.
//

import SwiftUI

struct ArcShape : Shape {
    func path(in rect: CGRect) -> Path {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        var p = Path()
        p.move(to: .zero)
        p.addLine(to: CGPoint(x: 0, y: height))
        p.addQuadCurve(to: CGPoint(x: rect.width, y: height), control: CGPoint(x: rect.width / 2, y: rect.height + height * 2))
        p.addLine(to: CGPoint(x: rect.width, y: 0))
        
        return p
    }
}

struct ArcShape1: Shape {
    func path(in rect: CGRect) -> Path {
        let window = UIApplication.shared.windows[0]
        let sHeight = window.safeAreaInsets.bottom
        let width = rect.width
        let height = rect.height
        var p = Path()
        p.move(to: CGPoint(x: 0, y: height))
        p.addLine(to: CGPoint(x: 0, y: height - sHeight))
        p.addQuadCurve(to: CGPoint(x: width, y: height-sHeight), control: CGPoint(x: width / 2, y: 0-(height-sHeight)))
        p.addLine(to: CGPoint(x: width, y: height))
        return p
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ArcShape1().frame(width: UIScreen.main.bounds.width, height: 150).background(Color.blue)
            
        }
        
    }
}
