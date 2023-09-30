//
//  MainViewModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation

class MainViewModel {
    func numberOfSection() -> Int {
        1
    }

    func numberOfRows(in section: Int) -> Int {
        10
    }

    func getData() {
        APICaller.getPokemons { result in
            switch result {
            case .success(let data):
                print("Pokemons \(data.results.first?.url)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
