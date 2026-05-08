//
//  Genre.swift
//  TV+
//
//  Created by neo on 5/8/26.
//

// MARK: - Genre
struct Genre: Codable {
    let genres: [GenreElement]
}

// MARK: - GenreElement
struct GenreElement: Codable, Identifiable {
    let id: Int
    let name: String
}
