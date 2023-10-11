//
//  DetailsPokemonViewModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 1.10.23.
//

import Foundation
import UIKit
// MARK: - DetailsPokemonViewModel.
final class DetailsPokemonViewModel {
    // Properties.
    private var detailPokemon: PokemonSelected
    private var pokemonImage: URL?
    var pokemonHeight: Int
    var pokemonName: String
    var pokemonWeight: Int
    var pokemonType: String
    private var id: Int
    private var image: UIImage?
    // Local FileManager
    private var fileManager =  LocalFileManager()
    // Initialization.
    init(detailPokemon: PokemonSelected) {
        self.detailPokemon = detailPokemon
        self.pokemonName = detailPokemon.name
        self.id = detailPokemon.id
        self.pokemonHeight = detailPokemon.height
        self.pokemonWeight = detailPokemon.weight
        self.pokemonType = detailPokemon.types.first?.type.name ?? ""
        self.pokemonImage = URL(string: detailPokemon.sprites.front_default ?? "")
        self.loadSavedData()
    }
    // MARK: - Create URL for the Pokemon image.
    private func makeImageURL() -> URL? {
        guard let imageURLString = detailPokemon.sprites.front_default else {
            return nil
        }
        return URL(string: imageURLString)
    }
    // MARK: - Save Pokemon data to the file system.
    private func saveData() {
        fileManager.saveString(pokemonName, withName: pokemonName)
        fileManager.saveInteger(pokemonHeight, withName: String(pokemonHeight))
        fileManager.saveInteger(pokemonWeight, withName: String(pokemonWeight))
        fileManager.saveString(pokemonType, withName: pokemonType)
    }
    // MARK: - Load previously saved Pokemon data from the file system.
    func loadSavedData() {
        if let savedName = fileManager.getString(named: pokemonName),
           let savedHeight = fileManager.getInteger(named: String(pokemonHeight)),
           let savedWeight = fileManager.getInteger(named: String(pokemonWeight)),
           let savedType = fileManager.getString(named: pokemonType) {
            self.pokemonName = savedName
            self.pokemonHeight = savedHeight
            self.pokemonWeight = savedWeight
            self.pokemonType = savedType
        }
    }
    // MARK: - Load the Pokemon image from the filemanager or network.
    func loadImage(completion: ((UIImage?) -> Void)?) {
        if let savedImage = fileManager.getImage(named: String(id)) {
            self.image = savedImage
            completion?(savedImage)
        } else {
            guard let imageURL = makeImageURL() else {
                completion?(nil)
                return
            }
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL),
                   let image = UIImage(data: data) {
                    self.image = image
                    self.fileManager.saveImage(from: imageURL, withName: String(self.id))
                    self.saveData()
                    DispatchQueue.main.async {
                        completion?(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion?(nil)
                    }
                }
            }
        }
    }
}
