//
//  PickerPopupView.swift
//  RecipeSwiftUI
//
//  Created by Gaurang Vyas on 05/02/21.
//  Copyright © 2021 Gaurang Vyas. All rights reserved.
//

import SwiftUI

struct PickerPopupView: View {
    var list: [String] = []
    @Binding var show: Bool
    @Binding var selectedIndex: Int
    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                //Picker
                Picker(selection: $selectedIndex, label: Text("")) {
                    ForEach(0 ..< list.count) {
                        Text(self.list[$0])
                    }
                }.frame(maxWidth: 300)
            }
        }
    }
}

