//
//  DetailsPokemonViewController.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 1.10.23.
//

import UIKit

class DetailsPokemonViewController: UIViewController {
    // Creating UI elements.
    private lazy var imageViewForPokemon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var pokemonHeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var pokemonType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var pokemonWeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // ViewModel.
    private var detailsViewModel: DetailsPokemonViewModel

    init(viewModel: DetailsPokemonViewModel) {
        self.detailsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        configView ()
        view.backgroundColor = .systemBackground
    }
    // Some configuration.
    private func configView () {
        self.title = "Pokemon details"
        pokemonName.text = detailsViewModel.pokemonName.capitalized
        pokemonHeight.text = "\(detailsViewModel.pokemonHeight.decimeterToCentimeter())"
        pokemonWeight.text = "\(detailsViewModel.pokemonWeight.hectogramToKilogram())"
        pokemonType.text = "\(detailsViewModel.pokemonType.capitalized) type"
        detailsViewModel.loadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.imageViewForPokemon.image = image
            }
        }
    }
    // Add views to the DetailsPokemonViewController.
    private func addViews() {
        view.addSubview(imageViewForPokemon)
        view.addSubview(pokemonHeight)
        view.addSubview(pokemonWeight)
        view.addSubview(pokemonType)
        view.addSubview(pokemonName)
    }
}

extension DetailsPokemonViewController {
    // Positioning and layout constraints for the UI elements.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pokemonName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            pokemonName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewForPokemon.topAnchor.constraint(equalTo: pokemonName.bottomAnchor, constant: 10),
            imageViewForPokemon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewForPokemon.widthAnchor.constraint(equalToConstant: 200),
            imageViewForPokemon.heightAnchor.constraint(equalToConstant: 200),
            pokemonHeight.topAnchor.constraint(equalTo: imageViewForPokemon.bottomAnchor, constant: 10),
            pokemonHeight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonWeight.topAnchor.constraint(equalTo: pokemonHeight.bottomAnchor, constant: 10),
            pokemonWeight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonType.topAnchor.constraint(equalTo: pokemonWeight.bottomAnchor, constant: 10),
            pokemonType.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonType.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -10)
        ])
    }
}
