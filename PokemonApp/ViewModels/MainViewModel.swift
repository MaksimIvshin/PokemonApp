//
//  MainViewModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation

class MainViewModel {

    var isLoanding: Observable<Bool> = Observable(false)
    var isLoandingDetails: Observable<Bool> = Observable(false)
    var isDetailsLoaded: Observable<Bool> = Observable(false)
    var cellDataSourse: Observable<[PokemonTableCellViewModel]> = Observable(nil)
    var dataSource: PokemonPage?
    var detailPokemon: PokemonSelected?

    func numberOfSection() -> Int {
        1
    }

    func numberOfRows(in section: Int) -> Int {
        self.dataSource?.results.count ?? 0
    }

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
                print(error)
            }
        }
    }

    func getDetailData(for index: Int) {
        if isLoandingDetails.value ?? true { return }
        self.isDetailsLoaded.value = false
        isLoandingDetails.value = true
        APICaller.getDetailPokemon(url: "https://pokeapi.co/api/v2/pokemon/\(index + 1)/") { [weak self] result in
            self?.isLoandingDetails.value = false
            switch result {
            case .success(let data):
                self?.detailPokemon = data
                self?.isDetailsLoaded.value = true
            case .failure(let error):
                print(error)
            }
        }
    }

    func mapCellData() {
        self.cellDataSourse.value = self.dataSource?.results.compactMap({ PokemonTableCellViewModel(pokemon: $0)
        })
    }
}
