//
//  RecipeSwiftui2pointOApp.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 06/02/21.
//

import SwiftUI
import Combine
import Firebase

@main
struct RecipeSwiftui2pointOApp: App {
    
    init() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
    }
    
    var body: some Scene {
        WindowGroup {
            
            MainMenuView()
        }
    }
    
    func setNavigationStyle() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .black
        UINavigationBar.appearance().isTranslucent = false
    }
}
