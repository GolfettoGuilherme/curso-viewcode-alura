//
//  FavoriteMovieViewController.swift
//  Cinetopia
//
//  Created by ALURA on 24/11/23.
//

import UIKit

class FavoriteMovieViewController: UIViewController {
    
    let movie = Movie(id: 1, title: "Avatar", image: "https://github.com/alura-cursos/movie-api/blob/main/images/avatar.jpg?raw=true", synopsis: "No exuberante mundo alienígena de Pandora vivem os Na'vi, seres que parecem ser primitivos, mas são altamente evoluídos. Como o ambiente do planeta é tóxico, foram criados os avatares, corpos biológicos controlados pela mente humana que se movimentam livremente em Pandora. Jake Sully, um ex-fuzileiro naval paralítico, volta a andar através de um avatar e se apaixona por uma Na'vi. Esta paixão leva Jake a lutar pela sobrevivência de Pandora.", rate: 9.4, releaseDate: "18/12/2009")
    
    // MARK: - UI Components
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
    }()
    
    private lazy var moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12.0
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
            
        return label
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        view.backgroundColor = .lightGray
        setupConstraints()
        setupView(movie)
    }
    
    // MARK: - Class methods
    
    private func setupConstraints() {
        view.addSubview(mainView)
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        mainView.widthAnchor.constraint(equalToConstant: 115).isActive = true
        
        mainView.addSubview(moviePosterImageView)
        moviePosterImageView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        moviePosterImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        moviePosterImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        moviePosterImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        mainView.addSubview(movieTitleLabel)
        movieTitleLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 12).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
    }
    
    func setupView(_ movie: Movie) {
        let url = URL(string: movie.image)
        moviePosterImageView.kf.setImage(with: url)
        
        movieTitleLabel.text = movie.title
    }
}

#Preview {
    FavoriteMovieViewController()
}
