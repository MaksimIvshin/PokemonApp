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
    var url: String
    var image: UIImage?
    var imageURL: URL?

    init(pokemon: Pokemon) {
        self.title = pokemon.name
        self.url = pokemon.url
        if let index = getIndexFromURL(pokemon.url) {
            self.imageURL = makeImageURL(pokemonIndex: index)
        }
    }

    func makeImageURL(pokemonIndex: Int) -> URL? {
        let baseURLString = NetworkingConstant.shared.imageServerAdress
        let imageURLString = baseURLString + "\(pokemonIndex).png"
        return URL(string: imageURLString)
    }

    func getIndexFromURL(_ urlString: String) -> Int? {
          guard let url = URL(string: urlString),
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                let lastPathComponent = components.path.split(separator: "/").last,
                let index = Int(lastPathComponent) else {
              return nil
          }
          return index
      }

    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = self.imageURL else {
            completion(nil)
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL),
                let image = UIImage(data: data) {
                self.image = image
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
