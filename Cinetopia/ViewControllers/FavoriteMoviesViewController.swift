//
//  FavoriteMoviesViewController.swift
//  Cinetopia
//
//  Created by ALURA on 24/11/23.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .yellow
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupConstraints()
    }
    
    // MARK: - Class methods
    
    private func setupConstraints() {
        
    }
    
}

#Preview {
    FavoriteMoviesViewController()
}


