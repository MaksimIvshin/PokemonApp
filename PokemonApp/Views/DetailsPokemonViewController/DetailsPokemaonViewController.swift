//
//  DetailsPokemonViewController.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 1.10.23.
//

import UIKit
// MARK: - DetailsPokemonViewController.
final class DetailsPokemonViewController: UIViewController {
    // Creating UI elements.
    private lazy var imageViewForPokemon = UIImageView()
    private lazy var pokemonName = UILabel()
    private lazy var pokemonHeight = UILabel()
    private lazy var pokemonType = UILabel()
    private lazy var pokemonWeight = UILabel()
    // MARK: - Model in DetailsPokemonViewController.
    private var detailsViewModel: DetailsPokemonViewModel
    // Initiliztion.
    init(viewModel: DetailsPokemonViewModel) {
        self.detailsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // View life cicle.
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        configView ()
        view.backgroundColor = .systemBackground
    }
    // Some configuration.
    private func configView () {
        self.title = "pokemonDetails".localized
        pokemonName.text = "pokemonsName".localized + ": " + "\(detailsViewModel.pokemonName.capitalized)"
        pokemonHeight.text = "pokemonsHeight".localized + ": " + "\(detailsViewModel.pokemonHeight.decimeterToCentimeter() + " " + "pokemonsCm".localized)"
        pokemonWeight.text = "pokemonsWeight".localized + ": " + "\(detailsViewModel.pokemonWeight.hectogramToKilogram() + " " + "pokemonsKg".localized)"
        pokemonType.text = "pokemonsType".localized + ": " + "\(detailsViewModel.pokemonType.capitalized)"
        detailsViewModel.loadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.imageViewForPokemon.image = image
            }
        }
    }
    // MARK: - Add views to the DetailsPokemonViewController.
    private func addViews() {
        let views = [imageViewForPokemon, pokemonName, pokemonHeight, pokemonType, pokemonWeight]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        views.forEach {
            view.addSubview($0)
        }
    }
}
// MARK: - Positioning and layout constraints for the UI elements.
extension DetailsPokemonViewController {
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
