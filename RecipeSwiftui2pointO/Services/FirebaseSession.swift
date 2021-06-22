//
//  FirebaseSession.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 09/02/21.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Combine


class FirebaseSession: ObservableObject {
    
    //MARK: Properties
    @Published var session: User?
    @Published var meals: [Meal] = Meal.all
    @Published var courses: [Course] = []
    @Published var recipes: [RecipeInfo] = []
    
    @Published var isLoggedIn: CurrentValueSubject<Bool, Never>
   
    var dbRef = Database.database().reference()
    var storRef = Storage.storage().reference()
   
    var mealRef: DatabaseReference {
        return dbRef.child("meals")
    }
    
    var profilePicRef: StorageReference {
        return storRef.child("profilePic")
    }
    
    var profileRef: DatabaseReference {
        return dbRef.child("profile")
    }
    
    var courseRef: DatabaseReference {
        return dbRef.child("Courses")
    }
    
    var recipeRef: DatabaseReference {
        return dbRef.child("recipes")
    }
    
    var recipePicRef: StorageReference {
        return storRef.child("recipeImages")
    }
    
    init() {
        isLoggedIn = CurrentValueSubject<Bool, Never>(Auth.auth().currentUser?.uid != nil)
        //Database.database().isPersistenceEnabled = true
        listen()
        
    }
    
    //MARK: Functions
    func listen() {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
                self.isLoggedIn.send(true)
                self.listenDatas()
            } else {
                self.isLoggedIn.send(false)
            }
        }
    }
    
    func listenDatas() {
        //self.getMeals()
        self.getProfileInfo()
        self.getCourses()
        self.getRecipes()
    }
    
    func logOut() {
        try! Auth.auth().signOut()
        //self.isLoggedIn.send(false)
    }
    
   /* func getMeals() {
        mealRef.observe(DataEventType.value) { snapshot in
            var array: [Meal] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let meals = Meal(snapshot: snapshot) {
                    array.append(meals)
                }
            }
            self.meals = array
        }
    }*/
    
    func getCourses() {
        courseRef.observe(DataEventType.value) { snapshot in
            var array: [Course] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let coure = Course(snapshot: snapshot) {
                    array.append(coure)
                }
            }
            self.courses = array
        }
    }
    
    func setProfileInfo(key: UserKeys, value: String) {
        guard let uid = session?.uid else {
            return
        }
        let ref = profileRef.child(uid)
        ref.setValue([key.rawValue: value])
    }
    
    func getProfileInfo() {
        guard let uid = session?.uid else {
            return
        }
        let ref = profileRef.child(uid)
        ref.observe(DataEventType.value) { snapshot in
            self.session?.setValues(snapshot)
            self.objectWillChange.send()
        }
    }
    
    func uploadProfile(image: UIImage, completion: @escaping (_ url: URL?) -> Void) {
        guard let uid = session?.uid else {
            return
        }
        let storageRef = profilePicRef.child("\(uid).jpg")
        if let uploadData = image.jpegData(compressionQuality: 1) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    storageRef.downloadURL { (url, error) in
                        completion(url)
                    }
                }
            }
        }
     }
    
    func uploadRecipeImage(image: UIImage, completion: @escaping (_ url: URL?) -> Void) {

        let storageRef = recipePicRef.child("\(UUID()).jpg")
        if let uploadData = image.jpegData(compressionQuality: 1) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    storageRef.downloadURL { (url, error) in
                        completion(url)
                    }
                }
            }
        }
     }
    
    func addNewRecipe(_ info: RecipeInfo) {
        let ref = recipeRef.childByAutoId()
        ref.setValue(info.dictionaryData)
    }
    
    func getRecipes() {
        recipeRef.observe(DataEventType.value) { snapshot in
            self.recipes = RecipeInfo.getRecipeList(snapshot)
            self.objectWillChange.send()
        }
    }
}
