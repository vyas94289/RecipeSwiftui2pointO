//
//  AddRecipeView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 10/02/21.
//

import SwiftUI

struct AddRecipeView: View {
    @Binding var selectedTab: Int
    @StateObject var session: FirebaseSession
    @State private var isShowPhotoLibrary = false
    @StateObject var viewModel = AddRecipeViewModel()
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Photo")) {
                    imageHeader
                }.listRowInsets(EdgeInsets())
                
                Section(header: Text("Recipe Info")) {
                    HStack {
                        Text("Recipe Name")
                        TextField("Recipe name", text: $viewModel.recipeName).multilineTextAlignment(.trailing)
                    }
                    Picker("Meal", selection: $viewModel.mealType) {
                        ForEach(session.meals, id: \.id) {
                            Text($0.name)
                        }
                    }
                    
                    Picker("Course", selection: $viewModel.courseType) {
                        ForEach(session.courses, id: \.id) {
                            Text($0.name)
                        }
                    }
                    
                    Stepper("Serving : \(viewModel.numberOfServesString)",
                            value: $viewModel.numberOfServes,
                            in: 0...130)
                    
                    Stepper("Preparation Time : \(viewModel.timeString)",
                            value: $viewModel.timeInMinutes,
                            in: 1...999)
                    
                    CustomSliderView(minValue: 50, maxValue: 250, value: $viewModel.calories).listRowInsets(EdgeInsets())
                    
                    NavigationLink("Ingredients", destination: IngredientsView(ingredients: Ingredient.all, selections: $viewModel.selectedIngredients))
                    
                    NavigationLink("Directions", destination: AddDirectionsView(directions: $viewModel.directions))
                }
            }
            .navigationTitle(Text("Add Recipe"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: navigationSaveButton)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$viewModel.image)
            }
            .onAppear() {
                viewModel.session = self.session
            }
            .onReceive(viewModel.viewDismissalModePublisher) { shouldDismiss in
                if shouldDismiss {
                    self.selectedTab = 0
                }
            }
            
        }
    }
    
    var imageHeader: some View {
        Button(action: {
            self.isShowPhotoLibrary = true
        }, label: {
            VStack{
                if viewModel.image == nil {
                    Image("recipe_placholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                } else {
                    Image(uiImage: viewModel.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                }
            }
            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(#colorLiteral(red: 0.9061788321, green: 0.9401052594, blue: 0.9760403037, alpha: 1)))
        })
        
    }
    
    @ViewBuilder
    var navigationSaveButton: some View {
        if viewModel.isSaving {
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.primaryClr))
        } else {
            Button("Save", action: viewModel.submit)
                .foregroundColor(viewModel.enableButton ? Color.primaryClr : Color.gray)
                .disabled(!viewModel.enableButton)
        }
    }
}

struct CustomSliderView: View {
    var minValue: Int
    var maxValue: Int
    @State var percentage: Float = 0
    @Binding var value: Int

    var body: some View {
        GeometryReader { geometry in
            // TODO: - there might be a need for horizontal and vertical alignments
            ZStack(alignment: .leading) {
                Rectangle()
                   .foregroundColor(Color(UIColor.systemGray5))
                .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
                HStack {
                    Text("Calories(\(minValue) to \(maxValue))")
                        .padding(.leading)
                    Spacer()
                    Text("\(value)").padding(.trailing)
                }
                
            }.contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    // TODO: - maybe use other logic here
                    self.percentage = min(max(0, Float(value.location.x / geometry.size.width * 100)), 100)
                    self.calculateValue()
                }))
        }
    }
    
    func calculateValue() {
        value = (Int(percentage * Float(maxValue - minValue) / 100)) + minValue
    }
}
