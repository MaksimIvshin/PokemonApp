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

    var cellDataSourse: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configView()
        setupIndicator()
        viewModel.getData()
    }

    private func configView() {
        setupTableView()

    }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)


        }

    func bindViewModel() {
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


}
