//
//  DetailsPokemonViewController.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 1.10.23.
//

import UIKit

class DetailsPokemonViewController: UIViewController {

    lazy var imageViewForPokemon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var pokemonHeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var pokemonType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var pokemonWeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //viewModel
    var detailsViewModel: DetailsPokemonViewModel

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
        view.backgroundColor = .white
    }

    func configView () {
        self.title = "Pokemon details"
        pokemonHeight.text = "\(detailsViewModel.pokemonHeight) ft"
        pokemonWeight.text = "\(detailsViewModel.pokemonWeight) kg"
        pokemonType.text = "\(detailsViewModel.pokemonType.capitalized)"
        detailsViewModel.loadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.imageViewForPokemon.image = image
            }
        }
    }

    func addViews() {
        view.addSubview(imageViewForPokemon)
        view.addSubview(pokemonHeight)
        view.addSubview(pokemonWeight)
        view.addSubview(pokemonType)
    }
}

extension DetailsPokemonViewController {
    func setupConstraints() {

        NSLayoutConstraint.activate([
            imageViewForPokemon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageViewForPokemon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewForPokemon.widthAnchor.constraint(equalToConstant: 200),
            imageViewForPokemon.heightAnchor.constraint(equalToConstant: 200),
            
            pokemonHeight.topAnchor.constraint(equalTo: imageViewForPokemon.bottomAnchor, constant: 10),
            pokemonHeight.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            pokemonType.topAnchor.constraint(equalTo: pokemonHeight.bottomAnchor, constant: 10),
            pokemonType.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            pokemonWeight.topAnchor.constraint(equalTo: pokemonType.bottomAnchor, constant: 10),
            pokemonWeight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonWeight.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -10)
        ])
    }
}
