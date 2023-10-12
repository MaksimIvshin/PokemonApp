//
//  MainViewController+TableView.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import UIKit
// MARK: - Setup tableView in MainViewController.
extension MainViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    // Some configuration.
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        title = "pokemonsMain".localized
        view.addSubview(activityIndicator)
        setupConstraints()
    }
    // Positioning and layout constraints for the UI elements.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    // Register MainPokemonCell.
    private func registerCells() {
        tableView.register(MainPokemonCell.self, forCellReuseIdentifier: MainPokemonCell.indetifier)
    }
    // Returns the number of sections in the table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }
    // Returns the number of rows in a specific section of the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    // Configures and returns a cell for a specific index path in the table view.
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
    // Reloads the table view.
    func reloadTableView(){
        tableView.reloadData()
    }
    // Returns the desired height for a cell at a specific index path.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    // Handles the selection of a row in the table view.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.getDetailData(for: indexPath.row)
    }
    //  Save some data when a cell is no longer displayed.
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellDataSourse.first?.saveTitle()
    }
    // When the user scrolls the content view data will update in the tableview.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            self.viewModel.getData()
        }
    }
}
