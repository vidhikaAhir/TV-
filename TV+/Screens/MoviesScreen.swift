//
//  MoviesScreen.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import SwiftUI

struct MoviesScreen: View {
    
    @StateObject var viewModel: MoviesViewModel
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Text("Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 8)
                        .padding(.leading, 16)
                        .foregroundColor(.white)
                }.frame(maxWidth: .infinity, alignment: .leading)
                CarauselMovies(geo: geo)
                    .frame(height: geo.size.height * 2.6/3)
                VStack(alignment: .leading) {
                    TrendingView(title: "Trending now", movies: viewModel.movieList )
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 15)
                    TrendingView(title: "Top movies", movies: viewModel.movieList )
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 15)
                    TrendingView(title: "Popular now", movies: viewModel.movieList )
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 15)
                    TrendingView(title: "Top shows", movies: viewModel.movieList )
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 15)
                }.foregroundStyle(Color.white)
            }
        }.background(Color.black)
    }
}

#Preview {
    MoviesScreen(viewModel: MoviesViewModel())
}
