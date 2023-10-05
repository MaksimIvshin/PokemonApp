//
//  MainViewModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation

class MainViewModel {
    //Properties
    var isLoanding: Observable<Bool> = Observable(false)
    var isLoandingDetails: Observable<Bool> = Observable(false)
    var isDetailsLoaded: Observable<Bool> = Observable(false)
    var cellDataSourse: Observable<[PokemonTableCellViewModel]> = Observable(nil)
    var dataSource: PokemonPage?
    var detailPokemon: PokemonSelected?
    // Return the number of sections in the table view.
    func numberOfSection() -> Int {
        1
    }
    // Return the number of rows in the given section.
    func numberOfRows(in section: Int) -> Int {
        self.dataSource?.results.count ?? 0
    }
    // Fetch Pokemon data from the API.
    func getData() {
            if isLoanding.value ?? true { return }
            isLoanding.value = true
            APICaller.getPokemons { [weak self] result in
                self?.isLoanding.value = false
                switch result {
                case .success(let data):
                    self?.dataSource = data
                    self?.mapCellData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    // Fetch detailed Pokemon data for the given index from the API.
    func getDetailData(for index: Int) {
        if isLoandingDetails.value ?? true { return }
        self.isDetailsLoaded.value = false
        isLoandingDetails.value = true
        APICaller.getDetailPokemon(url: "\(NetworkingConstant.shared.serverAdress)\(index + 1)/") { [weak self] result in
            self?.isLoandingDetails.value = false
            switch result {
            case .success(let data):
                self?.detailPokemon = data
                self?.isDetailsLoaded.value = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // Map the fetched Pokemon data to cell view models.
    func mapCellData() {
        self.cellDataSourse.value = self.dataSource?.results.compactMap({ PokemonTableCellViewModel(pokemon: $0)
        })
    }
}
