//
//  DetailsView.swift
//  IOS_native_exercise
//
//  Created by Gil casimiro on 03/06/24.
//

import SwiftUI
import SDWebImageSwiftUI


// View to display details of a selected movie
struct MovieDetailView: View {
    // The movie to display details for
    let movie: Movie
    
    var body: some View {
        // ScrollView to allow vertical scrolling of content
        ScrollView {
            VStack(alignment: .leading) {
                // Display the movie poster if the URL is available
                if let url = movie.posterURL {
                    WebImage(url: url)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                }
                // Display the original title of the movie
                Text(movie.originalTitle)
                    .font(.title)
                    .padding(.top, 10)
                
                // Display the overview/description of the movie
                Text(movie.overview)
                    .padding(.top, 10)
                
                Spacer()
            }
            .padding()
        }
        // Set the navigation title to the movie's title
        .navigationTitle(movie.title)
        // Set the background color of the view
        .background(Color.mint.ignoresSafeArea())
    }
}
