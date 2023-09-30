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

    var viewModel: MainViewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
    }

    private func configView() {
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.getData()
    }
}
