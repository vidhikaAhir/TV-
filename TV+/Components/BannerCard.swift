//
//  BannerView.swift
//  TV+
//
//  Created by neo on 5/8/26.
//

import SwiftUI

struct BannerCard : View {
    
    @EnvironmentObject var appData: AppData

    var movieDetails: MovieResult

    var loadImages : LoadImages {
        LoadImages(url: movieDetails.posterPath ?? "")
            
    }
        
    var body: some View {
        ZStack(alignment: .bottom, content: {
            CachedImageView(request: loadImages, contentMode: .fill)
            LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .center, endPoint: .bottom)
            VStack {
                Text(movieDetails.originalTitle ?? "")
                    .font(.system(size: 35, weight: .bold))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.7)
                    .shadow(color: .black.opacity(0.8), radius: 6)
                    .lineLimit(2)
                    .padding(.horizontal, 16)
                Text(getGenre())
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.7)
                    .shadow(color: .black.opacity(0.8), radius: 6)
                    .lineLimit(2)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
            }    .foregroundColor(.white)
        })
    }
    
    func getGenre() -> String {
        let genre = appData.genre?.genres
        let genreIDS = movieDetails.genreIDS
        
        guard let genre else { return ""}
        let filtered = genre
            .filter {(genreIDS ?? []).contains($0.id)}
            .map{$0.name}
        
        return filtered.prefix(4).joined(separator: "•")
    }
}
