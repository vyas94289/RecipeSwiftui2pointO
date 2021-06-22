//
//  AppError.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 12/06/21.
//

import Foundation

struct AppError {
    let message: String

    init(_ message: String) {
        self.message = message
    }
}

extension AppError {
    static var invalidUrl: AppError {
        return AppError("Invalid URL")
    }
}

extension AppError: LocalizedError {
    var errorDescription: String? { return message }
//    var failureReason: String? { get }
//    var recoverySuggestion: String? { get }
//    var helpAnchor: String? { get }
}
