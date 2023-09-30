//
//  MainViewModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation

class MainViewModel {

    var isLoanding: Observable<Bool> = Observable(false)
    var cellDataSourse: Observable<[Pokemon]> = Observable(nil)
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
                print("Pokemons \(data.results.first?.url)")
                self?.dataSource = data
                self?.mapCellData()
            case .failure(let error):
                print(error)
            }
        }
    }

    func mapCellData() {
        self.cellDataSourse.value = self.dataSource?.results ?? []
    }
}
