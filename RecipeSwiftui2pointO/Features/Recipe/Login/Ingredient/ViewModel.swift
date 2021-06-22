//
//  ViewModel.swift
//  RecipeSwiftUI
//
//  Created by Gaurang Vyas on 05/02/21.
//  Copyright © 2021 Gaurang Vyas. All rights reserved.
//

import Combine
import UIKit

struct KeyValue {
    var key: String
    var value: String
}

class ViewModel: ObservableObject {
    @Published var itemList: [ItemModel] = []
    @Published var currentIngr: ItemType  = ItemType.size
    var sink: AnyCancellable?
    init() {
        self.itemList = ItemModel.dummyData()
        
    }
    func addNewIngredient(_ value: String) {
        guard let item = itemList.first(where: {$0.type == currentIngr}) else {
            return
        }
        item.ingredient.append(.init(id: Int.random(in: 1000..<9999), title: value))
        objectWillChange.send()
    }
}
