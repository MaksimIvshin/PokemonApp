//
//  MainViewController.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import UIKit

class MainViewController: UIViewController {
    // Creating UI elements.
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.style = .large
        activity.color = .systemGray2
        activity.hidesWhenStopped = true
        return activity
    }()
    // Models.
    var viewModel: MainViewModel = MainViewModel()
    var cellDataSourse: [PokemonTableCellViewModel] = []
    // View life cicle.
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupTableView()
        viewModel.getData()
    }
    // ViewModel binding.
    func bindViewModel() {
        viewModel.isDetailsLoaded.bind { [weak self] isLoaded in
            guard let self = self, let isLoaded = isLoaded, isLoaded else {
                return
            }
            guard let dataSource = viewModel.detailPokemon else { return }
            presentView(pokemon: dataSource)
        }
        viewModel.isLoanding.bind { [weak self] isLoading in
            guard let self = self, let isLoanding = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoanding {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.cellDataSourse.bind { [weak self] pokemons in
            guard let self = self, let pokemons = pokemons else {
                return
            }
            self.cellDataSourse = pokemons
            self.reloadTableView()
        }
    }
    // Presenting DetailViewController.
    func presentView(pokemon: PokemonSelected) {
        let detail = DetailsPokemonViewModel(detailPokemon: pokemon)
        let detailViewController = DetailsPokemonViewController(viewModel: detail)
        detail.loadSavedData()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
