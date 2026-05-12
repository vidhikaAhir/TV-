//
//  SearchScreen.swift
//  TV+
//
//  Created by Vidhika Ahir on 10/05/26.
//

import SwiftUI
import SwiftData

struct SearchScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        Text("Search")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 8)
                            .padding(.leading, 16)
                            .foregroundColor(.white)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    SearchBar(text: $viewModel.searchText)
                    ZStack(alignment: .center) {
                        LazyVStack {
                            ForEach(viewModel.results) { item in
                                NavigationLink(value: item) {
                                    HStack(spacing: 12) {
                                        CachedImageView(request: LoadImages(url: item.posterPath ?? ""  ))
                                            .frame(width: 100, height: 150)
                                            .background(Color.gray.opacity(0.1))
                                            .padding(.horizontal, 5)
                                            .frame(width: 70, height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        Text(item.title ?? item.name ?? "")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .lineLimit(2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                        Button {
//                                            viewModel.bookmark(movies: item, context: modelContext)
//                                        } label: {
                                        Image(systemName: "chevron.right")
                                            .font(.title3)
                                            .foregroundColor(.white)
//                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            }
                        }
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                                .scaleEffect(1.5)
                        }
                    }
                } .task(id: viewModel.searchText) {
                    try? await Task.sleep(for: .milliseconds(500))
                    
                    let query = viewModel.searchText
                    await viewModel.search(query: query)
                }
            }.background(Color.black)
                .navigationDestination(for: MovieResult.self) { movie in
                    MovieDetails(movie: movie)
                }
        }
    }
}

#Preview {
    SearchScreen()
}


struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("",
                text: $text,
                prompt: Text("Search movies, shows...")
                    .foregroundColor(.white.opacity(0.6))

            )
            .tint(.white)
            .foregroundColor(.white)
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            Color.white.opacity(0.08)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 16)
    }
}
