//
//  PokemonModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation

struct PokemonPage: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct PokemonSelected: Codable {
    let id: Int
    let sprites: PokemonSpites
    let height: Int
    let weight: Int
    let types: [TypeElement]
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}

struct Species: Codable {
    let name: String
    let url: String
}

struct PokemonSpites: Codable {
    let front_default: String?
}
