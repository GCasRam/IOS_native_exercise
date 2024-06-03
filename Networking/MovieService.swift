//
//  MovieService.swift
//  IOS_native_exercise
//
//  Created by Gil casimiro on 03/06/24.
//

import Foundation
import Alamofire

// Class responsible for fetching movie data from an API
class MovieService {
    // API key for authenticating requests to The Movie Database (TMDb) API
    private let apiKey = "b66c9532aa45d7e8c6137972b701dabf"
    // Base URL for the TMDb API
    private let baseURL = "https://api.themoviedb.org/3"
    
    // Function to fetch popular movies
    // The completion handler returns a Result containing an array of Movie objects or an Error
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        // Construct the URL for the popular movies endpoint with the API key
        let url = "\(baseURL)/movie/popular?api_key=\(apiKey)"
        
        // Make a network request using Alamofire to the constructed URL
        AF.request(url).responseDecodable(of: MovieResponse.self) { response in
            // Handle the response by switching on the result
            switch response.result {
            // If the request is successful, pass the array of movies to the completion handler
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            // If the request fails, pass the error to the completion handler
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

