//
//  MovieServiceTests.swift
//  IOS_native_exercise
//
//  Created by Gil casimiro on 03/06/24.
//

import XCTest
@testable import IOS_native_exercise

final class MovieServiceTests: XCTestCase {

    var movieService: MovieService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        movieService = MovieService()
    }

    override func tearDownWithError() throws {
        movieService = nil
        try super.tearDownWithError()
    }

    func testFetchPopularMoviesSuccess() {
        // Given
        let expectation = self.expectation(description: "Fetch popular movies")
        
        // When
        movieService.fetchPopularMovies { result in
            // Then
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
                XCTAssertTrue(movies.count > 0)
            case .failure:
                XCTFail("Expected successful fetch of popular movies")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchPopularMoviesFailure() {
        // Given
        let invalidApiKey = "INVALID_API_KEY"
        let expectation = self.expectation(description: "Fetch popular movies with invalid API key")
        
        // When
        movieService.apiKey = invalidApiKey // Modify MovieService to accept external API key for testing
        movieService.fetchPopularMovies { result in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure due to invalid API key")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

