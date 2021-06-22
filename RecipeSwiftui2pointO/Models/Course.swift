//
//  Course.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 12/02/21.
//

import Foundation
import FirebaseDatabase

class Course: Identifiable {
    var id: String
    var name: String
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? String else {
            return nil
        }
        id = snapshot.key
        name = value
    }
}
