//
//  DashBoardViewModel.swift
//  IOS_native_exercise
//
//  Created by Gil casimiro on 03/06/24.
//

import Foundation
import Combine

// ViewModel class for managing and providing movie data to the view
class MovieViewModel: ObservableObject {
    // Published properties to notify views of updates
    @Published var movies: [Movie] = [] // List of movies
    @Published var isLoading: Bool = false // Indicates if data is currently being loaded
    @Published var errorMessage: String? // Holds error message if data loading fails

    // Instance of MovieService to fetch movie data
    private let movieService = MovieService()
    // Set to manage AnyCancellable instances for Combine
    private var cancellables = Set<AnyCancellable>()
    
    // Function to fetch movies
    func fetchMovies() {
        // Set isLoading to true and clear any previous error message
        isLoading = true
        errorMessage = nil

        // Fetch popular movies using the movie service
        movieService.fetchPopularMovies { [weak self] result in
            // Ensure UI updates are made on the main thread
            DispatchQueue.main.async {
                // Set isLoading to false as the request is complete
                self?.isLoading = false
                // Handle the result of the movie fetch
                switch result {
                // On success, update the movies list
                case .success(let movies):
                    self?.movies = movies
                // On failure, set an appropriate error message
                case .failure(let error):
                    self?.errorMessage = "Failed to load movies: \(error.localizedDescription)"
                }
            }
        }
    }
}
