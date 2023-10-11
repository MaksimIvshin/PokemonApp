//
//  NetworkingConstant.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation
// MARK: - Store for constant values.
final class NetworkingConstant {
    public static var shared: NetworkingConstant = NetworkingConstant()
    private init () {}
    public var serverAdress: String {
        get {
            return "https://pokeapi.co/api/v2/pokemon/"
        }
    }
    public var imageServerAdress: String {
        get {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        }
    }
    public var serverAdressForMorePokemons: String {
        get {
            return "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=10275"
        }
    }
}
