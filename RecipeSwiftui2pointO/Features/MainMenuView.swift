//
//  MainMenuView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 26/04/21.
//

import SwiftUI
import Combine

struct TitleSubtitleModel: Identifiable {
    var id = UUID()
    let title: String
    let subtitle: String?
    let view: AnyView?
    var shouldPresent: Bool = false
}

struct MainMenuView: View {
    @State var searchText: String = ""
    @State var filteredMenuArray: [TitleSubtitleModel] = []
    let menuArray: [TitleSubtitleModel] = [
        .init(title: "Recipe", subtitle: "Firebase Auth Database, Storage, Login Flow, Tabbar, Listing, Image Picker, Shape", view: nil, shouldPresent: true),
        .init(title: "Photos", subtitle: "LazyVGrid, URLSession, View States", view: PhotosView().eraseToAnyView()),
        .init(title: "Loading Indicator", subtitle: nil, view: LoadingIndicator().eraseToAnyView()),
        .init(title: "Debounce Search", subtitle: "Debounce search, Gradient, URLSession direct assign", view: DeboundView().eraseToAnyView()),
        .init(title: "Sticky Header", subtitle: "Custom tabbar", view: StickyTabbarView().eraseToAnyView())]
    @State var showRecipeView: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack(spacing: 0) {
                        Image(systemName: "magnifyingglass").foregroundColor(.gray)
                        TextField("Search terms here", text: $searchText)
                            .padding(.horizontal, 8)
                        Button(action: {
                            searchText = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                        })
                        .foregroundColor(searchText.isEmpty ? .gray : .primary)
                        .disabled(searchText.isEmpty)
                    }
                }
                Section {
                    ForEach(filteredMenuArray) { item in
                        if item.shouldPresent {
                            Button(action: {
                                showRecipeView = true
                            }, label: {
                                SubtitleCell(title: item.title,
                                             subtitle: item.subtitle)
                            }).padding(.vertical, 6)
                        } else {
                            NavigationLink(destination: item.view) {
                                SubtitleCell(title: item.title,
                                             subtitle: item.subtitle)
                            }.padding(.vertical, 6)
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showRecipeView, content: RecipeContentView.init)
            .navigationBarTitle("Menu", displayMode: .inline)
            .onChange(of: searchText) { text in
                withAnimation {
                    filter(text)
                }
            }
            .onAppear {
                filter("")
            }
        }
    }
    
    func filter(_ text: String) {
        if text.isEmpty {
            filteredMenuArray = menuArray
        } else {
            filteredMenuArray = menuArray.filter({
                $0.title.contains(text) || ($0.subtitle ?? "") .contains(text)
            })
        }
        
    }
    
   
}

struct SubtitleCell: View {
    var title: String
    var subtitle: String?
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).foregroundColor(.primary)
            if subtitle != nil {
                Text(subtitle ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
