
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
    private init() { }

    func saveImage(image: UIImage, imageName: String, folderName: String) {
        // Create folder.
        createFolderIfNeeded(folderName: folderName)
        guard let data = image.pngData(),
              let url = getUrlForImage(imageName: imageName, folderName: folderName)
        else { return }
        // Save image to path.
        do {
            try data.write(to: url)
        } catch let error {
            print("\(error.localizedDescription) \(imageName)")
        }
    }

    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }

    private func createFolderIfNeeded(folderName: String) {
        guard let url = getUrlForFolder(folderName: folderName) else { return }

        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("\(error.localizedDescription) \(folderName)")
            }
        }
    }

    private func getUrlForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }

    private func getUrlForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getUrlForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
