//
//  FavoriteCollectionReusableView.swift
//  Cinetopia
//
//  Created by Guilherme Golfetto on 05/08/24.
//

import UIKit

class FavoriteCollectionReusableView: UICollectionReusableView {
        
    //-----------------------------------------------------------------------
    // MARK: - Subviews
    //-----------------------------------------------------------------------
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()

    //-----------------------------------------------------------------------
    // MARK: - init
    //-----------------------------------------------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-----------------------------------------------------------------------
    // MARK: - private methods
    //-----------------------------------------------------------------------
    
    private func setupContraints() {
        addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //-----------------------------------------------------------------------
    // MARK: - public methods
    //-----------------------------------------------------------------------
    
    func setupTitle(_ text: String) {
        headerLabel.text = text
    }

}
