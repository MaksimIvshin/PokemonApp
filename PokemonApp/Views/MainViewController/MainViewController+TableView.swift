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
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        title = "Pokemons"
        view.addSubview(activityIndicator)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }

    func registerCells() {
        tableView.register(MainPokemonCell.self, forCellReuseIdentifier: MainPokemonCell.indetifier)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
        MainPokemonCell.indetifier, for: indexPath) as? MainPokemonCell else {
        return UITableViewCell()
        }
        let cellViewModel = cellDataSourse[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        cell.selectionStyle = .none
        return cell
    }

    func reloadTableView(){
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.getDetailData(for: indexPath.row)
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellDataSourse.first?.saveTitle()
    }
}
