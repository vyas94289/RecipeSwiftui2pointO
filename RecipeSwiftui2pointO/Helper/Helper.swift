//
//  Helper.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 12/02/21.
//

import Foundation
import Firebase

class Helper: ObservableObject {
    /*@Published var isLoggedIn: Bool = false
    init() {
        isLoggedIn = Auth.auth().currentUser?.uid != nil
        if isLoggedIn {
        }
    }*/
    
    static func minutesToHoursAndMinutes (_ minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    static func minutesToHoursAndMinutesString(_ minutes : Int) -> String {
        let time = Helper.minutesToHoursAndMinutes(minutes)
        if time.hours < 1 {
            return "\(time.leftMinutes) min"
        } else {
            return "\(time.hours)hr \(time.leftMinutes) min"
        }
    }
}
