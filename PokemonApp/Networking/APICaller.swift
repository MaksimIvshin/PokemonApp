//
//  APICaller.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}


public class APICaller {
    static func getPokemons(compltitionHandler: @escaping (_ result: Result<PokemonPage, NetworkError>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon"
        guard let url = URL(string: urlString) else {
            compltitionHandler(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PokemonPage.self, from: data) {
                compltitionHandler(.success(resultData))
            } else {
                compltitionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}
