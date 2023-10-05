//
//  PokemonTableCellViewModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation
import UIKit

class PokemonTableCellViewModel {
    var title: String

    let fileManager = FileManagerWrapper()

    init(pokemon: Pokemon) {
        self.title = pokemon.name
        loadTitle()
    }

    func loadTitle() {
        _ = fileManager.getString(named: title)
    }
    func saveTitle() {
        fileManager.saveString(title, withName: title)
    }
}
