//
//  TabBarController.swift
//  Cinetopia
//
//  Created by Guilherme Golfetto on 05/08/24.
//

import UIKit

//esse controller cuida da barra inferior do app, não precisa de nada alem desse metodo
class TabBarController: UITabBarController {

    //-----------------------------------------------------------------------
    // MARK: - View lifecycle
    //-----------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Class methods
    //-----------------------------------------------------------------------

    private func setupTabBarController() {
        let homeVC = UINavigationController(rootViewController: MoviesViewController())
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .medium)
        
        let homeSymbol = UIImage(systemName: "film", withConfiguration: symbolConfiguration)
        homeVC.tabBarItem.image = homeSymbol
        homeVC.tabBarItem.title = "Filmes populares"
        
        let favoritesVC = UINavigationController(rootViewController: FavoriteMoviesViewController())
        
        let heartSymbol = UIImage(systemName: "heart", withConfiguration: symbolConfiguration)
        favoritesVC.tabBarItem.image = heartSymbol
        favoritesVC.tabBarItem.title = "Favoritos"
        
        self.setViewControllers([homeVC, favoritesVC], animated: true)
    }
}
