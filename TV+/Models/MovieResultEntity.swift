//
//  MovieResultEntity.swift
//  TV+
//
//  Created by neo on 5/11/26.
//

import SwiftData

@Model
class MovieResultEntity {
    @Attribute(.unique) var id: Int
    var genreIDS: [Int]?
    var adult: Bool?
    var backdropPath: String?
    var originalTitle: String?
    var voteAverage: Double?
    var popularity: Double?
    var posterPath: String?
    var title: String?
    var overview: String?
    var originalLanguage: String?
    var voteCount: Int?
    var releaseDate: String?
    var name: String?
    var softcore: Bool?
    var video: Bool?

    init(id: Int, genreIDS: [Int]? = nil, adult: Bool? = nil, backdropPath: String? = nil, originalTitle: String? = nil, voteAverage: Double? = nil, popularity: Double? = nil, posterPath: String? = nil, title: String? = nil, overview: String? = nil, originalLanguage: String? = nil, voteCount: Int? = nil, releaseDate: String? = nil, name: String? = nil, softcore: Bool? = nil, video: Bool? = nil) {
        self.id = id
        self.genreIDS = genreIDS
        self.adult = adult
        self.backdropPath = backdropPath
        self.originalTitle = originalTitle
        self.voteAverage = voteAverage
        self.popularity = popularity
        self.posterPath = posterPath
        self.title = title
        self.overview = overview
        self.originalLanguage = originalLanguage
        self.voteCount = voteCount
        self.releaseDate = releaseDate
        self.name = name
        self.softcore = softcore
        self.video = video
    }
}

extension MovieResultEntity {
    convenience init(from movie: MovieResult) {
        self.init(
            id: movie.id ?? 0,
            genreIDS : movie.genreIDS,
            adult : movie.adult,
            backdropPath : movie.backdropPath,
            originalTitle : movie.originalTitle,
            voteAverage : movie.voteAverage,
            popularity : movie.popularity,
            posterPath : movie.posterPath,
            title : movie.title,
            overview : movie.overview,
            originalLanguage : movie.originalLanguage,
            voteCount : movie.voteCount,
            releaseDate : movie.releaseDate,
            name : movie.name,
            softcore : movie.softcore,
            video : movie.video
        )
    }
    
    func toMovieResult() -> MovieResult {
        MovieResult(
            genreIDS: self.genreIDS,
            adult: self.adult,
            backdropPath: self.backdropPath,
            id: self.id,
            originalTitle: self.originalTitle,
            voteAverage: self.voteAverage,
            popularity: self.popularity,
            posterPath: self.posterPath,
            title: self.title,
            overview: self.overview,
            originalLanguage: self.originalLanguage,
            voteCount: self.voteCount,
            releaseDate: self.releaseDate,
            name: self.name,
            softcore: self.softcore,
            video: self.video,
            isBookmarked: true
        )
    }
}
