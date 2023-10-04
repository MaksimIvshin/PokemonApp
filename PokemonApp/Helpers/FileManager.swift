
//
//  FileManager.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 4.10.23.
//

import Foundation
import UIKit

class LocalFileManager {
    static let shared = LocalFileManager()
    private let folderName = "Data"

    private init() {
        createFolderIfNeeded()
    }

    func saveImage(image: UIImage, imageName: String) {
        guard let data = image.pngData(),
              let url = getUrlForImage(imageName: imageName)
        else { return }
        do {
            try data.write(to: url)
        } catch let error {
            print("\(error.localizedDescription) \(imageName)")
        }
    }

    func getImage(imageName: String) -> UIImage? {
        guard let url = getUrlForImage(imageName: imageName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }

    func saveName(name: String, fileName: String) {
        guard let url = getUrlForFile(fileName: fileName) else { return }
        do {
            try name.write(to: url, atomically: true, encoding: .utf8)
        } catch let error {
            print("\(error.localizedDescription) \(fileName)")
        }
    }

    func getName(fileName: String) -> String? {
        guard let url = getUrlForFile(fileName: fileName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        do {
            let name = try String(contentsOf: url, encoding: .utf8)
            return name
        } catch let error {
            print("\(error.localizedDescription) \(fileName)")
            return nil
        }
    }

    private func createFolderIfNeeded() {
        guard let url = getUrlForFolder() else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("\(error.localizedDescription) \(folderName)")
            }
        }
    }

    private func getUrlForFolder() -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }

    private func getUrlForImage(imageName: String) -> URL? {
        guard let folderURL = getUrlForFolder() else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }

    private func getUrlForFile(fileName: String) -> URL? {
        guard let folderURL = getUrlForFolder() else {
            return nil
        }
        return folderURL.appendingPathComponent(fileName)
    }
}
