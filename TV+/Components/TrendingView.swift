//
//  TrendingView.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import SwiftUI

struct TrendingView: View {
    
    let title: String
    let movies : [Result]
    @EnvironmentObject var appData: AppData

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 25, weight: .bold))
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.7)
                .padding(.horizontal, 16)
                .foregroundColor(.white)
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(movies.enumerated(), id: \.offset) { index, movie in
                        VStack {
                            ZStack(alignment: .topLeading) {
                                CachedImageView(request: LoadImages(url: movie.posterPath))
                                    .frame(width: 100, height: 150)
                                    .background(Color.gray.opacity(0.1))
                                
                                    .padding(.horizontal, 5)
                                
                                Text("\(index + 1)")
                                    .font(.largeTitle)
                                    .shadow(color: .black,radius: 4, x:0, y: 0)
                                    .fontWeight(.bold)
                                    .padding(.top, 8)
                                    .padding(.leading, 16)
                                    .foregroundColor(.white)
                                VStack {
                                    Spacer()
                                    Text(movie.originalTitle)
                                        .font(.system(size: 12, weight: .bold))
                                        .multilineTextAlignment(.center)
                                        .minimumScaleFactor(0.7)
                                        .shadow(color: .black, radius: 6)
                                        .lineLimit(2)
                                        .padding(.horizontal, 16)
                                    Text(getGenre(movie: movie))
                                        .font(.system(size: 8, weight: .medium))
                                        .multilineTextAlignment(.center)
                                        .minimumScaleFactor(0.7)
                                        .shadow(color: .black, radius: 6)
                                        .lineLimit(2)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                }
                                .foregroundColor(.white)
                                .frame(width: 100, height: 150)
                                
                                
                            }
                        }
                    }
                }.padding()
            }
        }.background(Color.black)
    }
    
    func getGenre(movie: Result) -> String {
        let genre = appData.genre?.genres
        let genreIDS = movie.genreIDS
        
        guard let genre else { return ""}
        let filtered = genre
            .filter {genreIDS.contains($0.id)}
            .map{$0.name}
        
        return filtered.prefix(3).joined(separator: "•")
    }
}

#Preview {
    TrendingView(title: "Test", movies: [Result(genreIDS: [27, 53, 12], adult: false, backdropPath: "/i1yf91svRHX45l9BXL8rVFzLoPH.jpg", id: 578, originalTitle: "Jaws", voteAverage: 7.682, popularity: 13.0669, posterPath: "/tjbLSFwi0I3phZwh8zoHWNfbsEp.jpg", title: "Jaws", overview: "When the seaside community of Amity finds itself under attack by a dangerous great white shark, the town\'s chief of police, a young marine biologist, and a grizzled shark hunter embark on a desperate quest to kill the beast before it strikes again.", originalLanguage: "en", voteCount: 11477, releaseDate: "1975-06-20", softcore: false, video: false), Result(genreIDS: [28, 80, 53], adult: false, backdropPath: "/99W7BptqslScAyupDqg9NADLhh1.jpg", id: 1242332, originalTitle: "Normal", voteAverage: 7.1, popularity: 13.1215, posterPath: "/dHP7nurzOYGHNcNK1O4naVzsGCv.jpg", title: "Normal", overview: "Interim sheriff Ulysses, called to the snowbound town of Normal, MN, uncovers an international criminal conspiracy at the heart of the seemingly quaint whistle-stop when he comes to the aid of a bank-robbing couple caught up in a deadly mess.", originalLanguage: "en", voteCount: 26, releaseDate: "2026-04-16", softcore: false, video: false)])
}
