//
//  DashboardView.swift
//  IOS_native_exercise
//
//  Created by Gil casimiro on 03/06/24.
//

import SwiftUI
import SDWebImageSwiftUI

// Main view for displaying popular movies
struct ContentView: View {
    // StateObject to hold the view model
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        // NavigationView for enabling navigation between views
        NavigationView {
            VStack {
                // Show a loading indicator if movies are being loaded
                if viewModel.isLoading {
                    ProgressView("Loading movies...")
                        .padding()
                // Show an error message if there is an error
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                // Show the movies if data is loaded successfully
                } else {
                    ScrollView {
                        // LazyVGrid for displaying movies in a grid layout
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                            // Iterate through the movies and create a navigation link for each
                            ForEach(viewModel.movies) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    VStack {
                                        // Load and display the movie poster
                                        if let url = movie.posterURL {
                                            WebImage(url: url)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 200)
                                        }
                                        // Display the movie title
                                        Text(movie.title)
                                            .font(.headline)
                                            .lineLimit(1)
                                            .foregroundStyle(Color.black)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            // Set the navigation title for the view
            .navigationTitle("Popular Movies")
            // Set the background color of the view
            .background(Color.mint.ignoresSafeArea())
        }
        // Fetch movies when the view appears
        .onAppear {
            viewModel.fetchMovies()
        }
    }
}

#Preview {
    ContentView()
}


