//
//  String+extension.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 10.10.23.
//

import Foundation
// MARK: - Localized string.
extension String {
    var localized: String {
        NSLocalizedString(
            self,
            comment: "\(self) could not be found in Localizable.strings"
        )
    }
}
