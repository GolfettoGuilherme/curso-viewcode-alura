//
//  MoviesInteractor.swift
//  Cinetopia
//
//  Created by Guilherme Golfetto on 06/08/24.
//

import Foundation

protocol MoviesPresenterToInteractorProtocol: AnyObject {
    func fetchMovies() async throws -> [Movie]
}

class MoviesInteractor: MoviesPresenterToInteractorProtocol {
    
    //-----------------------------------------------------------------------
    // MARK: - Attributes
    //-----------------------------------------------------------------------
    
    private var movieService: MovieService = MovieService()

    //-----------------------------------------------------------------------
    // MARK: -  MoviesPresenterToInteractorProtocol
    //-----------------------------------------------------------------------
    
    func fetchMovies() async throws -> [Movie] {
        do {
            let movies = try await movieService.getMovies()
            return movies
        } catch (let error) {
            throw error
        }
    }
}
