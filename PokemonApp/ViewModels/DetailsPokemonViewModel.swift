//
//  DetailsPokemonViewModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 1.10.23.
//

import Foundation
import UIKit

class DetailsPokemonViewModel {

    var detailPokemon: PokemonSelected
    var pokemonImage: URL?
    var pokemonHeight: Int
    var pokemonWeight: Int
    var pokemonType: String
    var species: String?
    var image: UIImage?
    var imageURL: URL?

    init(detailPokemon: PokemonSelected) {
        self.detailPokemon = detailPokemon
        self.pokemonHeight = detailPokemon.height
        self.pokemonWeight = detailPokemon.weight
        self.pokemonType = detailPokemon.types.first?.type.name ?? ""
        self.species = detailPokemon.types.first?.type.name ?? ""
        self.pokemonImage = URL(string: detailPokemon.sprites.front_default ?? "")
    }

    func makeImageURL() -> URL? {
        guard let imageURLString = detailPokemon.sprites.front_default else {
            return nil
        }
        print(imageURLString)
        return URL(string: imageURLString)
    }

    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = makeImageURL() else {
            completion(nil)
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL),
               let image = UIImage(data: data) {
                self.image = image
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}

