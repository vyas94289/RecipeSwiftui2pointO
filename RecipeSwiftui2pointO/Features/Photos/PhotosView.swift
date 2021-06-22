//
//  PhotosView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 18/02/21.
//

import SwiftUI
import Combine

struct PhotosView: View {
    @State var showFilters: Bool = false
    @StateObject var viewModel = PhotosViewModel()
    private var gridItemLayout = [GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6)]
    var body: some View {
        content
            .navigationBarTitle("Photos", displayMode: .inline)
            .navigationBarItems(trailing: Button("Filter", action: {
                showFilters.toggle()
            }))
            .sheet(isPresented: $showFilters, content:{
                PhotosFilterView(filterPublisher: viewModel.filterPublisher)
            })
            .onAppear {
                viewModel.send(event: .onAppear)
            }
        
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .loading:
            return ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.primaryClr)).eraseToAnyView()
        case .error(let error):
            return Text(error).eraseToAnyView()
        case .loaded(let hits):
            return self.hits(hits).eraseToAnyView()
        }
    }
    
    private func hits(_ hits: [Hit]) -> some View {
        
        ScrollView {
            VStack {
                LazyVGrid(columns: gridItemLayout, spacing: 6) {
                    ForEach(hits, id: \.id) { hit in
                        URLImage(urlString: hit.webformatURL,
                                 placeholder: Image("recipe_placholder")
                                    .resizable().eraseToAnyView())
                            .aspectRatio(1, contentMode: .fill)
                    }
                }
                if viewModel.showLoading {
                    ProgressView()
                        .id(UUID())
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.primaryClr)).aspectRatio(1, contentMode: .fit)
                        .onAppear {
                            // self.viewModel.getData(viewModel.filterPublisher.value)
                        }
                }
            }.padding(6)
        }
    }
}


