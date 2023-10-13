//
//  APICaller.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//

import Foundation
import UIKit

// MARK: - Cases for possible error.
enum NetworkError: Error {
    case urlError
    case canNotParseData
    case noInternetConnection
}
// MARK: - Class for making API request and show alert.
public class APICaller {
    static func getPokemons(page: Int, compltitionHandler: @escaping (Result<PokemonPage, NetworkError>) -> Void) {
        var components = NetworkingURL.shared.serverAddress
        components.queryItems = [
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "offset", value: "\(page)")]
        guard let paginatedURL = components.url else {
            compltitionHandler(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: paginatedURL) { dataResponse, urlResponse, error in
            if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                compltitionHandler(.failure(.noInternetConnection))
                showAlert()
                return
            }
            if error == nil, let data = dataResponse {
                if let resultData = try? JSONDecoder().decode(PokemonPage.self, from: data) {
                    compltitionHandler(.success(resultData))
                } else {
                    compltitionHandler(.failure(.canNotParseData))
                }
            }
        }.resume()
    }
    static func getDetailPokemon(url: String, compltitionHandler: @escaping (_ result: Result<PokemonSelected, NetworkError>) -> Void) {
        let urlString = url
        guard let url = URL(string: urlString) else {
            compltitionHandler(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                compltitionHandler(.failure(.noInternetConnection))
                showAlert()
                return
            }
            if error == nil, let data = dataResponse {
                if let resultData = try? JSONDecoder().decode(PokemonSelected.self, from: data) {
                    compltitionHandler(.success(resultData))
                } else {
                    compltitionHandler(.failure(.canNotParseData))
                }
            }
        }.resume()
    }
    static func showAlert() {
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                return
            }
            var topViewController = rootViewController
            while let presentedViewController = topViewController.presentedViewController {
                topViewController = presentedViewController
            }
            let alert = UIAlertController(title: "No Internet Connection",
                                          message: "Please check your internet connection and try again.",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            topViewController.present(alert, animated: true, completion: nil)
        }
    }
}
