// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movie = try? JSONDecoder().decode(Movie.self, from: jsonData)

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let results: [Result]
    let totalPages, totalResults, page: Int

    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page
    }
}

// MARK: - Result
struct Result: Codable, Identifiable {
    let genreIDS: [Int]
    let adult: Bool
    let backdropPath: String
    let id: Int
    let originalTitle: String
    let voteAverage, popularity: Double
    let posterPath, title, overview, originalLanguage: String
    let voteCount: Int
    let releaseDate: String
    let softcore, video: Bool

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case popularity
        case posterPath = "poster_path"
        case title, overview
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case softcore, video
    }
}
