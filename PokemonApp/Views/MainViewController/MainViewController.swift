//
//  MainViewController.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import UIKit

class MainViewController: UIViewController {
    
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

    var viewModel: MainViewModel = MainViewModel()
    var cellDataSourse: [PokemonTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configView()
        viewModel.getData()
    }
    
    private func configView() {
        setupTableView()
    }

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

    func presentView(pokemon: PokemonSelected) {
        let detail = DetailsPokemonViewModel(detailPokemon: pokemon)
        let detailViewController = DetailsPokemonViewController(viewModel: detail)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
