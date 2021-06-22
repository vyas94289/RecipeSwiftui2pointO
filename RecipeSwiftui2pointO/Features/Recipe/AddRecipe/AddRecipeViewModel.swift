//
//  AddRecipeViewModel.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 10/02/21.
//

import Combine
import UIKit

class AddRecipeViewModel: ObservableObject {
    
    var session: FirebaseSession?
    
    @Published var image: UIImage?
    @Published var recipeName: String = ""
    @Published var calories: Int = 175
    @Published var mealType: String = "1"
    @Published var courseType: String = "1"
    @Published var numberOfServes: Int = 1
    @Published var numberOfServesString = ""
    @Published var timeInMinutes: Int = 1
    @Published var timeString: String = ""
    @Published var selectedIngredients: [Int] = []
    @Published var directions: [String] = []
    
    @Published var enableButton: Bool = false
    @Published var isSaving: Bool = false
    
    private var bag = Set<AnyCancellable>()
    
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
   
    init() {
        $timeInMinutes.sink(receiveValue: { minutes in
            self.timeString = Helper.minutesToHoursAndMinutesString(minutes)
        }).store(in: &bag)
        
        $numberOfServes.sink { serves in
            self.numberOfServesString = String(format: "%02d", serves)
        }.store(in: &bag)
        
        observeValidation()
    }
    
    func observeValidation() {
        Publishers.CombineLatest4($image, $recipeName, $selectedIngredients, $directions)
            .map { image, recipeName, selectedIngredients, directions -> Bool in
                return image != nil && !recipeName.isEmpty &&
                    !selectedIngredients.isEmpty && !directions.isEmpty
        }.assign(to: \.enableButton, on: self).store(in: &bag)
    }
    
    func submit() {
        isSaving = true
        uploadRecipeImage()
    }
    
    func clearAll() {
        image = nil
        recipeName = ""
        calories = 50
        mealType = "1"
        courseType = "1"
        numberOfServes = 1
        numberOfServesString = ""
        timeInMinutes = 1
        timeString = ""
        selectedIngredients = []
        directions = []
    }
    
    func uploadRecipeImage() {
        guard let image = self.image?.compressTo(0.5), let session = self.session else {
            return
        }
        isSaving = true
        session.uploadRecipeImage(image: image, completion: { (url) in
            self.isSaving = false
            guard let urlString = url?.absoluteString else {
                return
            }
            self.saveRecipe(imageUrl: urlString)
        })
    }
    
    func saveRecipe(imageUrl: String) {
        let recipe = RecipeInfo(image: imageUrl, recipeName: recipeName,
                                calories: calories, mealType: mealType,
                                courseType: courseType, numberOfServes: numberOfServes,
                                timeInMinutes: timeInMinutes, selectedIngredients: selectedIngredients,
                                directions: directions)
        session?.addNewRecipe(recipe)
        DispatchQueue.main.async {
            self.clearAll()
            self.isSaving = false
            self.viewDismissalModePublisher.send(true)
        }
    }
}
