
//
//  FileManager.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 4.10.23.
//

import Foundation
import UIKit

class FileManagerWrapper {
    let fileManager = FileManager.default
    let documentsDirectory: URL

    init() {
        documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func saveImage(from url: URL, withName name: String) {
        let destinationURL = documentsDirectory.appendingPathComponent(name)

        // Скачивание данных изображения по URL
        if let imageData = try? Data(contentsOf: url) {
            // Сохранение данных в файл
            do {
                try imageData.write(to: destinationURL)
                //print("Изображение успешно сохранено по пути: \(destinationURL.path)")
            } catch {
               // print("Ошибка при сохранении изображения: \(error.localizedDescription)")
            }
        } else {
            //print("Не удалось загрузить данные изображения по URL: \(url)")
        }
    }

    func saveString(_ string: String, withName name: String) {
        let stringFilePath = documentsDirectory.appendingPathComponent(name)

        do {
            try string.write(to: stringFilePath, atomically: true, encoding: .utf8)
            print("Строка успешно сохранена по пути: \(stringFilePath.path)")
        } catch {
            print("Ошибка при сохранении строки: \(error.localizedDescription)")
        }
    }

    func getImage(named name: String) -> UIImage? {
        let fileURL = documentsDirectory.appendingPathComponent(name)
        if let imageData = try? Data(contentsOf: fileURL),
           let image = UIImage(data: imageData) {
            print(image)
            return image
        }
        return nil
    }

    func getString(named name: String) -> String? {
        let fileURL = documentsDirectory.appendingPathComponent(name)
        if let stringData = try? String(contentsOf: fileURL, encoding: .utf8) {
           //print(stringData)
            return stringData
        }
        return nil
    }

    func fileExists(atPath path: String) -> Bool {
        return fileManager.fileExists(atPath: path)
    }

    func saveInteger(_ integer: Int, withName name: String) {
        let integerData = Data("\(integer)".utf8)
        let integerFilePath = documentsDirectory.appendingPathComponent(name)

        do {
            try integerData.write(to: integerFilePath)
         //   print("Целое число успешно сохранено по пути: \(integerFilePath.path)")
        } catch {
          //  print("Ошибка при сохранении целого числа: \(error.localizedDescription)")
        }
    }

    func getInteger(named name: String) -> Int? {
        let integerFilePath = documentsDirectory.appendingPathComponent(name)

        do {
            let integerData = try Data(contentsOf: integerFilePath)
            if let integerValue = Int(String(data: integerData, encoding: .utf8) ?? "") {
                return integerValue
            }
        } catch {
          //  print("Ошибка при получении целого числа: \(error.localizedDescription)")
        }
        return nil
    }


}

