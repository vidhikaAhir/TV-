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
        NavigationStack {
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
                        TrendingView(title: "Trending now", movies: viewModel.trendingMovies, onLoadMore: {
                            Task {
                                await viewModel.fetchMovies(listType: .trending)
                            }
                        } )
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 15)
                        TrendingView(title: "Top movies", movies: viewModel.topMovies, onLoadMore: {
                            Task {
                                await viewModel.fetchMovies(listType: .topMovies)
                            }
                        } )
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 15)
                        TrendingView(title: "Popular now", movies: viewModel.popularMovies, onLoadMore: {
                            Task {
                                await viewModel.fetchMovies(listType: .popular)
                            }
                        } )
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 15)
                        TrendingView(title: "Top shows", movies: viewModel.topShows, onLoadMore: {
                            Task {
                                await viewModel.fetchMovies(listType: .topShows)
                            }
                        } )
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 15)
                            .padding(.bottom, 50)
                    }.foregroundStyle(Color.white)
                }
            }.background(Color.black)
                .task {
                    await viewModel.fetchMovies(listType: nil)
                }
                .navigationDestination(for: MovieResult.self) { movie in
                    MovieDetails(movie: movie)
                }
        }
    }
}

#Preview {
    MoviesScreen(viewModel: MoviesViewModel())
}
