//
//  User.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 09/02/21.
//

import Foundation
import FirebaseDatabase
import Kingfisher
import UIKit
import FirebaseAuth

enum UserKeys: String {
    case uid
    case email
    case displayName
    case profileImage
}

class User: ObservableObject {
    
    var uid: String
    var email: String?
    var displayName: String?
    var profileImage: String?
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
    
    convenience init() {
        let info = Auth.auth().currentUser!
        self.init(uid: info.uid, displayName: info.displayName, email: info.email)
    }
    
    func setValues(_ snapshot: DataSnapshot) {
        for child in snapshot.children {
            if let snapshot = child as? DataSnapshot {
                setValue(child: snapshot)
            }
        }
    }
    
    func setValue(child: DataSnapshot) {
        guard let key = UserKeys(rawValue: child.key),
              let value = child.value as? String else {
            return
        }
        setValue(key: key, value: value)
    }
    
    func setValue(key: UserKeys, value: String) {
        switch key {
        case .uid:
            uid = value
        case .email:
            email = value
        case .displayName:
            displayName = value
        case .profileImage:
            profileImage = value
        }
        self.objectWillChange.send()
    }
}
