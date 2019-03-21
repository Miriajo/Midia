//
//  MovieTests.swift
//  MidiaTests
//
//  Created by Miriam Sánchez on 18/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import XCTest

class MovieTests: XCTestCase {
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    var bestMovie: Movie!
    
    let posterURL = URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Video/v4/87/53/17/8753170e-df31-8d20-39c2-525e9ce0f3d6/source/100x100bb.jpg")
    
    override func setUp() {
        super.setUp()

        bestMovie = Movie(movieId: 391465654, title: "Top Gun - Ídolos del aire", directors: ["Tony Scott"], releaseDate: Date(timeIntervalSinceNow: 13213), synopsis: "Una hábil conbinación de acción, música e increíble fotografía aérea, hicieron de Top Gun Ídolos del Aire el gran éxito de 1986. Se trata de una apasionante mirada a los peligros y emociones que esperan a cada piloto de una prestigiosa academia de aviación del ejército. Tom Cruise ofrece una soberbia actuación como Maverick Mitchell, un joven y arriesgado piloto destinado a convertirse en el mejor, y Kelly McGillis resulta brillante como la profesora civil que enseña a Maverick algunas cosas que no se pueden aprender en clase.", posterURL: posterURL, rating: nil, numberOfReviews: nil, price: 9)
        
    }
   
    
    func testMovieExistence() {
        XCTAssertNotNil(bestMovie)
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
            XCTAssertNotNil(firstMovie?.title)
        } catch {
            XCTFail()
        }
        
        
    }
    
    func testEncodeMovie() {
        do{
            let movieData = try encoder.encode(bestMovie)
            
            XCTAssertNotNil(movieData)
            
        } catch {
            XCTFail()
        }
        
    }
    
    func testDecodeEncodedDetailedMovie() {

        do {

            let movieData = try encoder.encode(bestMovie)
            XCTAssertNotNil(movieData)

            let movie = try decoder.decode(Movie.self, from: movieData)

            XCTAssertNotNil(movie)
            XCTAssertNotNil(movie.movieId)
            XCTAssertNotNil(movie.title)
            XCTAssertNotNil(movie.directors)
            XCTAssertNotNil(movie.releaseDate)
            XCTAssertNotNil(movie.synopsis)
            XCTAssertNotNil(movie.posterURL)
            XCTAssertNotNil(movie.price)

        } catch {
            XCTFail()
        }

    }
    
    func testPersistOnUserDefaults() {
      
    }
    
}
