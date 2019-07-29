//
//  MovieTests.swift
//  MidiaTests
//
//  Created by Dani rica on 15/07/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import XCTest

class MovieTests: XCTestCase {
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    let coverURL = URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Video6/v4/61/b7/df/61b7dfc3-eb31-b545-cd8f-215def28af4d/source/100x100bb.jpg")
    var bestMovieEver: Movies!
    
    override func setUp() {
        super.setUp()
        
        let dateFormatter = ISO8601DateFormatter()
        bestMovieEver = Movies(movieId: 1, title: "Back to the future", artistName: "Robert Zemeckis", releaseDate: dateFormatter.date(from: "1985-07-03T07:00:00Z"), description: "Back to the Future opened on July 3, 1985, on 1,200 screens in North America. Zemeckis was concerned the film would flop because Fox had to film a Family Ties special in London and was unable to promote the film. Gale was also dissatisfied with Universal Pictures' tagline Are you telling me my mother's got the hots for me?", coverURL: coverURL, duration: 6962803, genre: "Comedia", price: 5.99)
    }
    
    func testBookExistence() {
        XCTAssertNotNil(bestMovieEver)
    }
    
    func testDecodeMovieCollection() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "movie-search-response", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let movieCollection = try decoder.decode(MovieCollection.self, from: data)
            XCTAssertNotNil(movieCollection)
            let firstMovie = movieCollection.results?.first!
            XCTAssertNotNil(firstMovie?.movieId)
            XCTAssertNotNil(firstMovie?.artistName)
            XCTAssertNotNil(firstMovie?.description)
            XCTAssertNotNil(firstMovie?.releaseDate)
            XCTAssertNotNil(firstMovie?.coverURL)
            XCTAssertNotNil(firstMovie?.duration)
            XCTAssertNotNil(firstMovie?.genre)
            XCTAssertNotNil(firstMovie?.price)
        } catch {
            XCTFail()
        }
    }
    
    func testEncodeMovie() {
        do {
            let movieData = try encoder.encode(bestMovieEver)
            XCTAssertNotNil(movieData)
        } catch {
            XCTFail()
        }
    }
    
    func testDecodeEncodedDetailedMovie() {
        do {
            let movieData = try encoder.encode(bestMovieEver)
            XCTAssertNotNil(movieData)
            let movie = try decoder.decode(Movies.self, from: movieData)
            XCTAssertNotNil(movie)
            XCTAssertNotNil(movie.movieId)
            XCTAssertNotNil(movie.artistName)
            XCTAssertNotNil(movie.description)
            XCTAssertNotNil(movie.releaseDate)
            XCTAssertNotNil(movie.coverURL)
            XCTAssertNotNil(movie.duration)
            XCTAssertNotNil(movie.genre)
            XCTAssertNotNil(movie.price)
        } catch {
            XCTFail()
        }
    }
    /*
    func testPersistOnUserDefaults() {
        let userDefaults = UserDefaults.init(suiteName: "tests")!
        let bookKey = "bookKey"
        do {
            let movieData = try encoder.encode(bestMovieEver)
            userDefaults.set(bookData, forKey: bookKey)
            userDefaults.synchronize()
            if let retrievedBookData = userDefaults.data(forKey: bookKey) {
                let decodedBook = try decoder.decode(Book.self, from: retrievedBookData)
                XCTAssertNotNil(decodedBook)
            } else {
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
    */
}
