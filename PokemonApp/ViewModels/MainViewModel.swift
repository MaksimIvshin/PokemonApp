//
//  MainViewModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation
// MARK: - MainViewModel.
final class MainViewModel {
    // MARK: - Observable properties.
    var isLoanding: Observable<Bool> = Observable(false)
    private var isLoandingDetails: Observable<Bool> = Observable(false)
    var isDetailsLoaded: Observable<Bool> = Observable(false)
    var cellDataSourse: Observable<[PokemonTableCellViewModel]> = Observable(nil)
    private var dataSource: PokemonPage?
    var detailPokemon: PokemonSelected?
    // Return the number of sections in the table view.
    func numberOfSection() -> Int {
        1
    }
    // Return the number of rows in the given section.
    func numberOfRows(in section: Int) -> Int {
        self.dataSource?.results.count ?? 0
    }
    // MARK: - Fetch Pokemon data from the API.
    func getData() {
        if isLoanding.value ?? true { return }
        isLoanding.value = true
        let page = self.dataSource?.results.count ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            APICaller.getPokemons(page: page) { [weak self] result in
                self?.isLoanding.value = false
                switch result {
                case .success(let data):
                    if let existingData = self?.dataSource {
                        var updatedData = existingData
                        updatedData.results.append(contentsOf: data.results)
                        self?.dataSource = updatedData
                    } else {
                        self?.dataSource = data
                    }
                    self?.mapCellData()
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    // MARK: - Fetch detailed Pokemon data for the given index from the API.
    func getDetailData(for index: Int) {
        if isLoandingDetails.value ?? true { return }
        self.isDetailsLoaded.value = false
        isLoandingDetails.value = true
        APICaller.getDetailPokemon(url: "\(NetworkingURL.shared.serverAddress)\(index + 1)/") { [weak self] result in
            self?.isLoandingDetails.value = false
            switch result {
            case .success(let data):
                self?.detailPokemon = data
                self?.isDetailsLoaded.value = true
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    // MARK: - Map the fetched Pokemon data to cell view models.
    private func mapCellData() {
        self.cellDataSourse.value = self.dataSource?.results.compactMap({ PokemonTableCellViewModel(pokemon: $0)
        })
    }
}
