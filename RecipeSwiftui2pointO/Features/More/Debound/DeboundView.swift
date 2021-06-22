//
//  DeboundView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 22/02/21.
//

import SwiftUI

struct DeboundView: View {
    @State var search: String = ""
    @StateObject var viewModel = DeboundViewModel()
    var body: some View {
        VStack {
            HStack {
                TextField("Search terms here", text: $viewModel.search)
                    .padding(.horizontal, 8)
            }
            .padding(8)
            .background(Color(.systemGray5))
            .cornerRadius(6)
            .padding(.horizontal)
            MoviesListView(movies: viewModel.movies)
            Spacer()
        }.navigationTitle("Debounce Search")
    }
}

struct MoviesListView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(movies, id: \.id) { movie in
                    HStack(spacing: 14) {
                        URLImage(urlString: movie.i.imageURL,
                                 placeholder: Image("recipe_placholder")
                                    .resizable()
                                    .eraseToAnyView())
                            .aspectRatio(0.8, contentMode: .fit)
                            .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text(movie.l).bold()
                            Spacer()
                            Text(movie.s).font(.caption)
                            Spacer()
                            Text(String(movie.y)).font(.caption)
                        }.padding(.vertical, 6)
                        Spacer()
                    }
                    .frame(height: 100)
                    .padding(8)
                    .background(RandomGrandient())
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                }
            }.padding(.vertical, 20).animation(.spring())
        }
    }
}

struct RandomGrandient: View {
    
    let index: Int = Int.random(in: 0..<6)
    
    let colors: [[Color]] = [[Color(#colorLiteral(red: 0.3810339007, green: 0.7539081573, blue: 0.9414382577, alpha: 1)),Color(#colorLiteral(red: 0.4926635623, green: 0.6383730769, blue: 0.9697086215, alpha: 1))],
                             [Color(#colorLiteral(red: 0.812318325, green: 0.5016258955, blue: 0.8416396976, alpha: 1)),Color(#colorLiteral(red: 0.7674090266, green: 0.2121509612, blue: 0.5005549788, alpha: 1))],
                             [Color(#colorLiteral(red: 0.9584456086, green: 0.6916486025, blue: 0.3971389532, alpha: 1)),Color(#colorLiteral(red: 0.9425006509, green: 0.628651619, blue: 0.3530435264, alpha: 1))],
                             [Color(#colorLiteral(red: 0.7940148711, green: 0.4789105058, blue: 0.9481443763, alpha: 1)),Color(#colorLiteral(red: 0.609746933, green: 0.5014381409, blue: 0.9636083245, alpha: 1))],
                             [Color(#colorLiteral(red: 0.409750998, green: 0.9094809294, blue: 0.7994988561, alpha: 1)),Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))],
                             [Color(#colorLiteral(red: 0.9343832135, green: 0.3923438191, blue: 0.5534318686, alpha: 1)),Color(#colorLiteral(red: 0.9036090374, green: 0.1210579125, blue: 0.4915061593, alpha: 1))]]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors[index]), startPoint: .top, endPoint: .bottom)
    }
}
