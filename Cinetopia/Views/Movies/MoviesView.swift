//
//  MoviesView.swift
//  Cinetopia
//
//  Created by Guilherme Golfetto on 06/08/24.
//

import UIKit

//regras de negocio
protocol MoviesViewProtocol: AnyObject {
    func setPresenter(_ presenter: MoviesPresenterToViewProtocol)
    func setupView(with movies: [Movie])
    func reloadData()
    func reloadRow(at indexPath: IndexPath)
    func toogle(_ isActive: Bool)
}

class MoviesView: UIView {

    //-----------------------------------------------------------------------
    // MARK: - Subviews
    //-----------------------------------------------------------------------

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        return tableView
    }()
    
    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Pesquisar"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        return searchBar
    }()
    
    //-----------------------------------------------------------------------
    // MARK: - Private attributes
    //-----------------------------------------------------------------------

    private var filteredMovies: [Movie] = []
    private var isSearchActive: Bool = false
    private var movies: [Movie] = []
    
    private var presenter: MoviesPresenterToViewProtocol?
    
    //-----------------------------------------------------------------------
    // MARK: - Init
    //-----------------------------------------------------------------------

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .background

        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Class methods
    //-----------------------------------------------------------------------
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}

//-----------------------------------------------------------------------
// MARK: - UITableViewDataSource e UITableViewDelegate
//-----------------------------------------------------------------------

extension MoviesView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredMovies.count : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell {
            let movie = isSearchActive ? filteredMovies[indexPath.row] : movies[indexPath.row]
            cell.configureCell(movie: movie)
            cell.delegate = self //diz que o viewcontroller vai implementar o protocolo q liga ele a celula e sabe responder ao evento de click dela
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = isSearchActive ? filteredMovies[indexPath.row] : movies[indexPath.row]
        
        presenter?.didSelectMovie(movie: movie) //avisando o presenter q foi selecionado
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

//-----------------------------------------------------------------------
// MARK: - MovieTableViewCellDelegate
//-----------------------------------------------------------------------

extension MoviesView: MovieTableViewCellDelegate {
    
    //evento que recebe quando acontece o click
    func didSelectFavoriteButton(sender: UIButton) {
        //a celula que sofreu o click
        guard let cell = sender.superview?.superview as? MovieTableViewCell else {
            return
        }
        
        //para pegar o indexpath necessário
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let selectedMovie = movies[indexPath.row]
        
        presenter?.didSelectFavoriteButton(selectedMovie)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

//-----------------------------------------------------------------------
// MARK: - MoviesViewProtocol
//-----------------------------------------------------------------------

extension MoviesView: MoviesViewProtocol {
    
    func setPresenter(_ presenter: any MoviesPresenterToViewProtocol) {
        self.presenter = presenter
    }    
    
    func setupView(with movies: [Movie]) {
        self.movies = movies
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func reloadRow(at indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func toogle(_ isActive: Bool) {
        self.isSearchActive = isActive
    }
}

//-----------------------------------------------------------------------
// MARK: - UISearchBarDelegate
//-----------------------------------------------------------------------

extension MoviesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        presenter?.didSearchText(
            searchBar,
            textDidChange: searchText,
            movies,
            &filteredMovies
        )
        
        tableView.reloadData()
    }
}
