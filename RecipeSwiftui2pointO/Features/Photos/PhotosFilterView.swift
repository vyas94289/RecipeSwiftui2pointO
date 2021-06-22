//
//  PhotosFilterView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 19/02/21.
//

import SwiftUI
import Combine

struct PhotosFilterView: View {
    @StateObject var viewModel = PhotosFilterViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var filterPublisher: CurrentValueSubject<PhotoFilter, Never>
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $viewModel.photoType, label: Text("Photo Type")) {
                    ForEach(viewModel.allPhotoType, id: \.self) { type in
                        Text(type)
                    }
                }
                Picker(selection: $viewModel.category, label: Text("Category")) {
                    ForEach(viewModel.allCategory, id: \.self) { type in
                        Text(type)
                    }
                }
                Picker(selection: $viewModel.color, label: Text("Color")) {
                    ForEach(viewModel.allColors, id: \.self) { type in
                        Text(type)
                    }
                }
                Picker(selection: $viewModel.order, label: Text("Order")) {
                    ForEach(viewModel.allOrders, id: \.self) { type in
                        Text(type)
                    }
                }
                HStack {
                    Text("Per Page : \(Int(viewModel.perPage))").frame(width: 150, alignment: .leading)
                    Slider(value: $viewModel.perPage, in: 3...300).accentColor(.primaryClr)
                }
            }
            .navigationBarTitle("Photo Filter", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close", action: {
                filterPublisher.send(viewModel.filter)
                presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}
