//
//  AddDirectionsView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 15/02/21.
//

import SwiftUI

struct AddDirectionsView: View {
    @Binding var directions: [String]
    @State var inputText: String = ""
    var body: some View {
        Form {
            Section(header: HStack{
                Text("Add Step")
                Spacer()
                Button("Add", action: addStep)
            }) {
                TextEditor(text: $inputText)
            }
            
            Section {
                ForEach(directions, id: \.self) { step in
                    Text(step).font(.caption)
                }
            }
        }
        .navigationBarTitle(Text("Directions"), displayMode: .inline)
    }
    
    func addStep() {
        if !inputText.isEmpty {
            directions.append(inputText)
            inputText = ""
        }
    }
}

struct AddDirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddDirectionsView(directions: .constant(["Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut."]))
        }
        
    }
}
