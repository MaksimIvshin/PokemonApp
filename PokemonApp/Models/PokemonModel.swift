//
//  PokemonModel.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1")
}

struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
