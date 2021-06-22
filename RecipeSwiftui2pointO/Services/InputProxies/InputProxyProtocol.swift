//
//  InputProxyProtocol.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 08/02/21.
//

import Foundation

protocol InputProxyProtocol {
    
    var type: TextFieldType { get set }
    
    // Wrapped value
    var value: String { get set }
    var error: String { get }
    var state: TextFieldState { get }

    // Published property wrapper
    var valuePublished: Published<String> { get }
    var errorPublished: Published<String> { get }
    var statePublished: Published<TextFieldState> { get }

    // Publisher
    var valuePublisher: Published<String>.Publisher { get }
    var errorPublisher: Published<String>.Publisher { get }
    var statePublisher: Published<TextFieldState>.Publisher { get }
    
    func validate(value: String)
    
    func resign()
}
