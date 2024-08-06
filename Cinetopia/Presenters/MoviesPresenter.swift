//
//  MoviesPresenter.swift
//  Cinetopia
//
//  Created by Guilherme Golfetto on 06/08/24.
//

import UIKit

protocol MoviesPresenterToViewControllerProtocol: AnyObject {
    func setViewController(_ controller: MoviesViewControllerToPresenterProtocol)
    func viewDidLoad()
    func viewDidAppear()
}

protocol MoviesPresenterToViewProtocol: AnyObject {
    func didSelectMovie(movie: Movie)
    func didSelectFavoriteButton(_ movie: Movie)
    func didSearchText(_ searchBar: UISearchBar, textDidChange searchText: String, _ movies: [Movie], _ filteredMovies: inout  [Movie])
}


class MoviesPresenter: MoviesPresenterToViewControllerProtocol {
    
    //-----------------------------------------------------------------------
    // MARK: - Attributes
    //-----------------------------------------------------------------------
    
    private var controller: MoviesViewControllerToPresenterProtocol?
    private var view: MoviesViewProtocol?
    private var interactor: MoviesPresenterToInteractorProtocol?
    
    //-----------------------------------------------------------------------
    // MARK: - Init
    //-----------------------------------------------------------------------

    init(view: MoviesViewProtocol,
         interactor: MoviesPresenterToInteractorProtocol?) {
        
        self.view = view
        self.interactor = interactor
    }
    
    //-----------------------------------------------------------------------
    // MARK: - MoviesPresenterToViewControllerProtocol
    //-----------------------------------------------------------------------

    func viewDidLoad() {
        view?.setPresenter(self)
        
        Task {
            await fetchMovies()
        }
    }
    
    func viewDidAppear() {
        view?.reloadData()
    }
    
    func setViewController(_ controller: any MoviesViewControllerToPresenterProtocol) {
        self.controller = controller
    }
    
    //-----------------------------------------------------------------------
    // MARK: - class methods
    //-----------------------------------------------------------------------

    private func fetchMovies() async {
        do {
            guard let movies = try await interactor?.fetchMovies() else { return }
            view?.setupView(with: movies)
            view?.reloadData()
        } catch (let error) {
            print(error)
        }
    }
}

//-----------------------------------------------------------------------
// MARK: - MoviesPresenterToViewProtocol (os eventos dos componentes da tela
//-----------------------------------------------------------------------

extension MoviesPresenter: MoviesPresenterToViewProtocol {
    
    func didSelectMovie(movie: Movie) {
        controller?.didSelectMovie(movie)
    }
    
    func didSelectFavoriteButton(_ movie: Movie) {
        movie.changeSelectionStatus()
        
        MovieManager.shared.add(movie) //adiciona pelo singleton na memoria
    }
    
    func didSearchText(_ searchBar: UISearchBar, textDidChange searchText: String, _ movies: [Movie], _ filteredMovies: inout [Movie]) {
        
        if searchText.isEmpty {
            view?.toogle(false)
        } else {
            filteredMovies = movies.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased())
            }
            view?.toogle(true)
        }
        
    }
}
