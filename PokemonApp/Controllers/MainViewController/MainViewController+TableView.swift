//
//  MainViewController+TableView.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTableView() {
        self.registerCells()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.view.backgroundColor = .blue
        self.view.addSubview(tableView)
        self.title = "Pokemons"
        self.setupConstraints()

    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }

    func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
