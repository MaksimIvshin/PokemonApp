//
//  NetworkingConstant.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation
// MARK: - Protocol for url values.
protocol NetworkingURLProtocol {
    var serverAddress: URLComponents { get }
    var imageServerAddress: URLComponents { get }
    var serverAddressForMorePokemons: URLComponents { get }
}
// MARK: - Store for url values.
final class NetworkingURL: NetworkingURLProtocol {
    public static var shared: NetworkingURL = NetworkingURL()
    private init () {}

    public var serverAddress: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        components.path = "/api/v2/pokemon/"
        return components
    }

    public var imageServerAddress: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "raw.githubusercontent.com"
        components.path = "/PokeAPI/sprites/master/sprites/pokemon/"
        return components
    }

    public var serverAddressForMorePokemons: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        components.path = "/api/v2/pokemon/"
        components.queryItems = [
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "limit", value: "1000")
        ]
        return components
    }
}
