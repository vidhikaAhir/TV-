//
//  APIRequests.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import Foundation

class PopularMoviesList : APIRequestHelper {
    typealias response = Movie
    var url : String 
    var body: Data? { nil }
    init(url: String) {
        let encoded =
        url.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) ?? "1"
        

        self.url = "movie/popular?page=\(encoded)"
    }

}

class TrendingMoviesList : APIRequestHelper {
    typealias response = Movie
    var url : String
    var body: Data? { nil }
    
    init(url: String) {
        let encoded =
        url.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) ?? "1"
        

        self.url = "trending/all/day?page=\(encoded)"
    }

}

class TopMoviesList : APIRequestHelper {
    typealias response = Movie
    var url : String
    var body: Data? { nil }
    
    init(url: String) {
        let encoded =
        url.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) ?? "1"
        

        self.url = "movie/top_rated?page=\(encoded)"
    }

}

class TopShowsList : APIRequestHelper {
    typealias response = Movie
    var url : String
    var body: Data? { nil }
    
    init(url: String) {
        let encoded =
        url.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) ?? "1"
        

        self.url = "tv/popular?page=\(encoded)"
    }

}

class UpcomingMoviesList : APIRequestHelper {
    typealias response = Movie
    var url : String { "movie/upcoming" }
    var body: Data? { nil }
}

class GenreList : APIRequestHelper {
    typealias response = Genre
    var url : String { "genre/movie/list" }
    var body: Data? { nil }
}

class SearchMulti: APIRequestHelper {
    typealias response = Movie
    var url: String
    var body: Data? { nil }
    
    init(url: String) {
        let encoded =
        url.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) ?? ""
        

        self.url = "search/multi?query=\(encoded)"
    }

}

class LoadImages : APIRequestHelper {
    typealias response = Data
    var baseUrl: String { "https://image.tmdb.org/t/p/w500" }
    var url : String
    var body: Data? { nil }
    var headers: [String : String] = [            
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNzhkMjQzYmFhYTUzMWIzZDE5ZDcwMjI4YzhiZDgyNiIsIm5iZiI6MTc3ODEzMzQ1NC42MDksInN1YiI6IjY5ZmMyOWNlMzVlMmE4ZjkxMWE2NDcwNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LSmhmnlQH7PvCduiD8num6mEn66fAB2VSdn-NMGzouw"
]
    
    init(url: String) {
        self.url = url
    }
}


