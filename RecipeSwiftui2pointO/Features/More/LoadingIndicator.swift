//
//  LoadingIndicator.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 05/03/21.
//

import SwiftUI

struct LoadingIndicator: View {
    @State var circleEnd: CGFloat = 0.2
    @State var rotationDegree: Angle = Angle(degrees: -90)
    let trackerRotation: Double = 1
    let animationDuration: Double = 1.35
    var body: some View {
        Circle()
            .trim(from: 0, to: circleEnd).stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
            .fill(Color.white)
            .rotationEffect(rotationDegree)
            .frame(width: 60, height: 60, alignment: .center)
            .onAppear {
                animate()
                Timer.scheduledTimer(withTimeInterval: animationDuration * 1.98, repeats: true) { _ in
                    reset()
                    animate()
                }
            }
        
    }
    // MARK:- functions
    func animate() {
        withAnimation(Animation.easeOut(duration: animationDuration)) {
            self.circleEnd = 1
        }
        withAnimation(Animation.easeOut(duration: animationDuration * 1.1)) {
            self.rotationDegree = .degrees(365)
        }
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(Animation.easeOut(duration: animationDuration)) {
                self.rotationDegree = .degrees(990)
                self.circleEnd = 0.001
            }
        }
    }
    
    func reset() {
        self.rotationDegree = .degrees(-90)
        
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
