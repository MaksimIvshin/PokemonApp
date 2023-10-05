
//
//  FileManager.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 4.10.23.
//

import UIKit

class LocalFileManager {
    // Properties.
    let fileManager = FileManager.default
    let documentsDirectory: URL
    // Initialization.
    init() {
        documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    // Save an image to the document directory.
    func saveImage(from url: URL, withName name: String) {
        let destinationURL = documentsDirectory.appendingPathComponent(name)
        if let imageData = try? Data(contentsOf: url) {
            do {
                try imageData.write(to: destinationURL)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Can't download URL: \(url)")
        }
    }
    // Save a string to the document directory.
    func saveString(_ string: String, withName name: String) {
        let stringFilePath = documentsDirectory.appendingPathComponent(name)
        do {
            try string.write(to: stringFilePath, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    // Load an image from the document directory.
    func getImage(named name: String) -> UIImage? {
        let fileURL = documentsDirectory.appendingPathComponent(name)
        if let imageData = try? Data(contentsOf: fileURL),
           let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    // Load a string from the document directory.
    func getString(named name: String) -> String? {
        let fileURL = documentsDirectory.appendingPathComponent(name)
        if let stringData = try? String(contentsOf: fileURL, encoding: .utf8) {
            return stringData
        }
        return nil
    }
    // Save an integer to the document directory.
    func saveInteger(_ integer: Int, withName name: String) {
        let integerData = Data("\(integer)".utf8)
        let integerFilePath = documentsDirectory.appendingPathComponent(name)
        do {
            try integerData.write(to: integerFilePath)
        } catch {
            print(error.localizedDescription)
        }
    }
    // Retrieve an integer from the document directory.
    func getInteger(named name: String) -> Int? {
        let integerFilePath = documentsDirectory.appendingPathComponent(name)

        do {
            let integerData = try Data(contentsOf: integerFilePath)
            if let integerValue = Int(String(data: integerData, encoding: .utf8) ?? "") {
                return integerValue
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
