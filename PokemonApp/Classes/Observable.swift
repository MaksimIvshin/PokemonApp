//
//  Observable.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation
// MARK: - The observable generic class for tracking changes to value of T type.
final class Observable<T> {
    private var listener: ((T?) -> Void)?
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    init(_ value: T? ) {
        self.value = value
    }
    func bind(_ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
