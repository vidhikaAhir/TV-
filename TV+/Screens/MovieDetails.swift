//
//  MovieDetails.swift
//  TV+
//
//  Created by neo on 5/11/26.
//

import SwiftUI
import SwiftData

struct MovieDetails: View {
    
    var movie: MovieResult
    @StateObject private var viewModel = DetailsViewModel()
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    CachedImageView(request: LoadImages(url: movie.backdropPath ?? ""), contentMode: .fit)
                        .padding(.bottom)
                    HStack(alignment: .top, spacing: 12) {
                        CachedImageView(request: LoadImages(url: movie.posterPath ?? ""  ))
                            .frame(width: 100, height: 150)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.title ?? movie.name ?? "")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.white)
                                .lineLimit(2)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 8) {
                                    ForEach(viewModel.getGenre(genre: appData.genre?.genres ?? [], movie: movie), id: \.self) { item in
                                        Text(item)
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 5)
                                            .background(
                                                Capsule()
                                                    .fill(.ultraThinMaterial)
                                                    .overlay(
                                                        Capsule()
                                                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                                                    )
                                            )
                                    }
                                }
                            }
                            .frame(height: 30)
                            
                            Text(movie.releaseDate?.split(separator: "-").first.map(String.init) ?? "")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)

                            
                            HStack(spacing: 4) {
                                Image(systemName: "star")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                                
                                Text("\(Int(viewModel.convertValue(movie.voteAverage ?? 0.0)))%")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Text(movie.overview ?? movie.name ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    
                    
                    
                }
            }
        }.background(Color.black)
            .task{
                viewModel.isMovieBookmarked(movieID: movie.id ?? 0, context: modelContext)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.toggleBookmark(movie: movie, context: modelContext)
                    } label: {
                        Image(systemName: viewModel.isBookMarked ? "bookmark.fill" : "bookmark")
                    }
                }
            }
    }
    
}

#Preview {
    var movie = MovieResult(genreIDS: [27, 53, 12], adult: false, backdropPath: "/i1yf91svRHX45l9BXL8rVFzLoPH.jpg", id: 578, originalTitle: "Jaws", voteAverage: 7.682, popularity: 13.0669, posterPath: "/tjbLSFwi0I3phZwh8zoHWNfbsEp.jpg", title: "Jaws", overview: "When the seaside community of Amity finds itself under attack by a dangerous great white shark, the town\'s chief of police, a young marine biologist, and a grizzled shark hunter embark on a desperate quest to kill the beast before it strikes again.", originalLanguage: "en", voteCount: 11477, releaseDate: "1975-06-20", name: "test", softcore: false, video: false)
    
    MovieDetails(movie: movie)
}
