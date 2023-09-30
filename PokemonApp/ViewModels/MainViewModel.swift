//
//  MainViewModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation

class MainViewModel {

    var isLoanding: Observable<Bool> = Observable(false)
    var cellDataSourse: Observable<[PokemonTableCellViewModel]> = Observable(nil)
    var dataSource: PokemonPage?

    func numberOfSection() -> Int {
        1
    }

    func numberOfRows(in section: Int) -> Int {
        self.dataSource?.results.count ?? 0
    }

    func getData() {
        if isLoanding.value ?? true {
            return
        }
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

    func mapCellData() {
        self.cellDataSourse.value = self.dataSource?.results.compactMap({ PokemonTableCellViewModel(pokemon: $0)
        })
    }

    func getPokemonTitle(_ pokemon: PokemonTableCellViewModel) -> String {
        return pokemon.title
    }
}
