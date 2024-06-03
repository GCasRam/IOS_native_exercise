//
//  MoviesModel.swift
//  IOS_native_exercise
//
//  Created by Gil casimiro on 03/06/24.
//

import Foundation


// Structure to decode the response from the API which contains an array of movies
struct MovieResponse: Codable {
    let results: [Movie] // Array of Movie objects
}
// Structure representing a movie, conforming to Codable and Identifiable protocols
struct Movie: Codable, Identifiable {
    let id: Int // Unique identifier for the movie
    let posterPath: String? // Path to the movie's poster image
    let title: String // Title of the movie
    let originalTitle: String // Original title of the movie
    let overview: String // Overview/description of the movie
    let popularity: Float // Popularity score of the movie
    
    // Enum to map JSON keys to Swift properties
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case originalTitle = "original_title"
        case overview
        case popularity
    }
    // Computed property to generate the full URL for the movie's poster image
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(posterPath)")
    }
}
