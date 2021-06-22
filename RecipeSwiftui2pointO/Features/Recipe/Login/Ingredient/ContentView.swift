//
//  ContentView.swift
//  RecipeSwiftUI
//
//  Created by Gaurang Vyas on 04/02/21.
//  Copyright © 2021 Gaurang Vyas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var presentSheet: Bool = false
    @State var isShowingPopover = false
    @State var textFieldValue: String = ""
    @StateObject var viewModel = ViewModel()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView {
            ScrollView(.vertical, content: {
                VStack(alignment: .leading, spacing: 30) {
                    defaultIngView
                    modifierAvalailable
                    Spacer()
                }
                .padding(30)
            })
            .sheet(isPresented: $presentSheet, content: { AddIngredientView(title: viewModel.currentIngr.rawValue, saved: { value in
                viewModel.addNewIngredient(value)
            })})
            .navigationBarTitle(Text("Add New Product"), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var defaultIngView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Default Ingredients")
            HStack(spacing: 10) {
                ForEach(viewModel.itemList) { item in
                    Button(action: {
                        withAnimation {
                            item.showPopUp.toggle()
                            viewModel.objectWillChange.send()
                        }
                        
                    }, label: {
                        DefaultIngItemView(model: item)
                    })
                    .popover(isPresented: Binding<Bool>(get: {
                        item.showPopUp
                    }, set: {
                        item.showPopUp = $0
                    })) {
                        Text("Hi from a popover")
                            .padding()
                            .frame(width: 320, height: 100)
                    }
                    .foregroundColor(.gray)
                }
            }
        }
    }
    
    var modifierAvalailable: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Modifier Available")
            
            ForEach(viewModel.itemList) { item in
                VStack {
                    HStack {
                        Text(item.type.rawValue).font(.subheadline)
                        Spacer()
                        Button("+ Add") {
                            self.viewModel.currentIngr = item.type
                            self.presentSheet = true
                        }.modifier(AddButtonStyle())
                    }
                    Divider()
                    LazyVGrid(columns: gridItemLayout, spacing: 8) {
                        ForEach(item.ingredient) { ingredient in
                            VStack(alignment: .leading) {
                                Button {
                                    ingredient.selected.toggle()
                                    viewModel.objectWillChange.send()
                                } label: {
                                    HStack {
                                        Image(systemName: ingredient.selected ? "checkmark.square" : "square")
                                        Text(ingredient.name)
                                    }
                                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                if ingredient.selected {
                                    TextField("", text: Binding<String>(
                                                get: {ingredient.value}, set: {ingredient.value = $0}))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    Spacer()
                                }
                            }
                            .foregroundColor(Color.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                    }.padding(.vertical, 8)
                }.modifier(CardStyle())
            }
            
        }
    }
    
}

struct DefaultIngItemView: View {
    let model: ItemModel
    var body: some View {
        HStack {
            Text(model.type.rawValue)
            Image(systemName: "chevron.down")
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth: 1))
    }
}
