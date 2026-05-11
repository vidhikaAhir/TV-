//
//  WatchList.swift
//  TV+
//
//  Created by neo on 5/11/26.
//

import SwiftUI
import SwiftData

struct WatchListScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = WatchListViewModel()
    @StateObject private var searchViewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        Text("Watchlist")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 8)
                            .padding(.leading, 16)
                            .foregroundColor(.white)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    ZStack(alignment: .center) {
                        LazyVStack {
                            ForEach(viewModel.results) { item in
                                NavigationLink(value: item) {
                                    HStack(spacing: 12) {
                                        CachedImageView(request: LoadImages(url: item.posterPath ?? "" ))
                                            .frame(width: 100, height: 150)
                                            .background(Color.gray.opacity(0.1))
                                            .padding(.horizontal, 5)
                                            .frame(width: 70, height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        Text(item.title ?? item.originalTitle ?? item.name ?? "")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .lineLimit(2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Button {
                                            viewModel.toggleBookmark(movie: item, context: modelContext)
                                        } label: {
                                            Image(systemName: item.isBookmarked ?? false ? "bookmark.fill" : "bookmark")
                                                .font(.title3)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                }
                            }
                        }
                        
                    }
                }.task {
                    viewModel.fetchBookmarkedMovies(context: modelContext)
                }
            }.background(Color.black)
                .navigationDestination(for: MovieResult.self) { movie in
                    MovieDetails(movie: movie)
                }
        }
    }
}
