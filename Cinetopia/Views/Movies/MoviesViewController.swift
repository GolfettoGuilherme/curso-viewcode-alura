//
//  MoviesViewController.swift
//  Cinetopia
//
//  Created by Giovanna Moeller on 30/10/23.
//

import UIKit

protocol MoviesViewControllerToPresenterProtocol : AnyObject {
    func didSelectMovie(_ movie: Movie)
}

class MoviesViewController: UIViewController {
    
    private var presenter: MoviesPresenterToViewControllerProtocol?
    
    //-----------------------------------------------------------------------
    // MARK: - Subviews
    //-----------------------------------------------------------------------
    
    private var mainView: MoviesView?
    
    //-----------------------------------------------------------------------
    // MARK: - Init
    //-----------------------------------------------------------------------

    init(mainView: MoviesView,
         presenter: MoviesPresenterToViewControllerProtocol) {
    
        super.init(nibName: "", bundle: nil)
        
        self.mainView = mainView
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-----------------------------------------------------------------------
    // MARK: - view lifecycle
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        presenter?.setViewController(self)
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear() //atualizar a tableview sempre que a tela reaparecer
    }
    
    override func loadView() {
        //onde dizemos qual view q o viewcontrolle vai carregar
        view = mainView
    }
    
    //-----------------------------------------------------------------------
    // MARK: - private methods
    //-----------------------------------------------------------------------
    
    private func setupNavigationBar() {
        title = "Filmes Populares"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.titleView = mainView?.searchBar
    }
}

//-----------------------------------------------------------------------
// MARK: - MoviesViewControllerToPresenterProtocol
//-----------------------------------------------------------------------

extension MoviesViewController: MoviesViewControllerToPresenterProtocol {
    //faz a navegação pra proxima tela
    func didSelectMovie(_ movie: Movie) {
        let detailsVC = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(detailsVC, animated: true)
    }    
}
