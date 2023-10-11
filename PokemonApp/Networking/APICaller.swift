//
//  APICaller.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation

// MARK: - Cases for possible error.
enum NetworkError: Error {
    case urlError
    case canNotParseData
    case noInternetConnection
}
// MARK: - Class for making API request.
public class APICaller {
    static func getPokemons(compltitionHandler: @escaping (_ result: Result<PokemonPage, NetworkError>) -> Void) {
        let urlString = NetworkingURL.shared.serverAddressForMorePokemons.string ?? ""
        guard let url = URL(string: urlString) else {
            compltitionHandler(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                compltitionHandler(.failure(.noInternetConnection))
                return
            }
            if error == nil, let data = dataResponse {
                if let resultData = try? JSONDecoder().decode(PokemonPage.self, from: data) {
                    compltitionHandler(.success(resultData))
                } else {
                    compltitionHandler(.failure(.canNotParseData))
                }
            }
        }.resume()
    }
    static func getDetailPokemon(url: String, compltitionHandler: @escaping (_ result: Result<PokemonSelected, NetworkError>) -> Void) {
        let urlString = url
        guard let url = URL(string: urlString) else {
            compltitionHandler(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                compltitionHandler(.failure(.noInternetConnection))
                return
            }
            if error == nil, let data = dataResponse {
                if let resultData = try? JSONDecoder().decode(PokemonSelected.self, from: data) {
                    compltitionHandler(.success(resultData))
                } else {
                    compltitionHandler(.failure(.canNotParseData))
                }
            }
        }.resume()
    }
}
