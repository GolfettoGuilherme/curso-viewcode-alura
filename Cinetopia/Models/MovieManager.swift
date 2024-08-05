//
//  MovieManager.swift
//  Cinetopia
//
//  Created by Guilherme Golfetto on 05/08/24.
//

import Foundation

class MovieManager {
    
    //-----------------------------------------------------------------------
    // MARK: - attributes
    //-----------------------------------------------------------------------
    
    static let shared = MovieManager()
    var favoritesMovies: [Movie] = []
    
    //-----------------------------------------------------------------------
    // MARK: - Init
    //-----------------------------------------------------------------------
    
    private init() { }

    //-----------------------------------------------------------------------
    // MARK: - class methods
    //-----------------------------------------------------------------------
    
    func add(_ movie: Movie) {
        if favoritesMovies.contains(where: { $0.id == movie.id }) {
            remove(movie)
        } else {
            favoritesMovies.append(movie)
        }
    }
    
    func remove(_ movie: Movie) {
        if let index = favoritesMovies.firstIndex(where: { $0.id == movie.id }) {
            favoritesMovies.remove(at: index)
        }
    }

}
