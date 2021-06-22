//
//  TextFieldState.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 08/02/21.
//

import Foundation
import SwiftUI

public enum TextFieldState {
    case normal
    case error
    case success
    case incomplete
    
    var color: Color {
        switch self {
        case .normal:
            return .white
        case .error:
            return .red
        case .success:
            return .green
        case .incomplete:
            return .yellow
        }
    }
}
