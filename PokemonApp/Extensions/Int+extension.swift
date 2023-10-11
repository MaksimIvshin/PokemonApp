//
//  Int+extension.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 4.10.23.
//

import Foundation
// MARK: - Hectogram to kilogram.
extension Int {
    func hectogramToKilogram() -> String {
        let kilograms = Double(self) / 10.0
        return "\(kilograms)"
    }
}
// MARK: - Decimeter to centimeter.
extension Int {
    func decimeterToCentimeter() -> String {
        let centimeters = self * 10
        return "\(centimeters)"
    }
}

