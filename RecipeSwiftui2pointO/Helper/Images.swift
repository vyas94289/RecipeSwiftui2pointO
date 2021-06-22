//
//  Images.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 06/02/21.
//

import Foundation
import UIKit

enum Images {
    static let background = "background_ recipe"
    static let darkBackground = "background"
    static let logo = "recipe_logo"
    
    static func getSystem(name: String, of size: CGFloat) -> UIImage {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: size, weight: .regular, scale: .default)
        let largeBoldImage = UIImage(systemName: name, withConfiguration: largeConfig)
        return largeBoldImage!.withRenderingMode(.alwaysTemplate)
    }
}
