//
//  PokemonTableCellViewModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation
import UIKit

class PokemonTableCellViewModel {
    // Properties
    var title: String
    // Local FileManager
    let fileManager = LocalFileManager()
    // Initialization.
    init(pokemon: Pokemon) {
        self.title = pokemon.name
        self.loadTitle()
    }
    // Load previously saved Pokemon data from the file system.
    func loadTitle() {
        if let savedTitle = fileManager.getString(named: title) {
            self.title = savedTitle
        }
    }
    // Save Pokemon data to the file system.
    func saveTitle() {
        fileManager.saveString(title, withName: title)
    }
}
