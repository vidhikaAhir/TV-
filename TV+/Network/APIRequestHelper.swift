//
//  APIRequestHelper.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import Foundation

protocol APIRequestHelper {
    associatedtype response: Codable
    
    var baseUrl: String { get }
    var url: String { get }
    var body: Data? { get }
    var headers: [String: String] { get }
    var httpMethod: String { get }
}

extension APIRequestHelper {
    var baseUrl: String {
        "https://api.themoviedb.org/3/"
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var headers: [String : String] {
        [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNzhkMjQzYmFhYTUzMWIzZDE5ZDcwMjI4YzhiZDgyNiIsIm5iZiI6MTc3ODEzMzQ1NC42MDksInN1YiI6IjY5ZmMyOWNlMzVlMmE4ZjkxMWE2NDcwNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LSmhmnlQH7PvCduiD8num6mEn66fAB2VSdn-NMGzouw"
        ]
        
    }
}


