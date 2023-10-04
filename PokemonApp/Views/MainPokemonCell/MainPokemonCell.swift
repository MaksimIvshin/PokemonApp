//
//  MainPokemonCell.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//
import UIKit

class MainPokemonCell: UITableViewCell {

    public static var indetifier: String {
        get{
            return "MainPokemonCell"
        }
    }

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var imageViewForCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
        setupCell()
    }

    func addViews() {
        containerView.addSubview(nameLabel)
        containerView.addSubview(typeLabel)
        containerView.addSubview(imageViewForCell)
        contentView.addSubview(containerView)
    }

    func setupCell() {
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
    }

    func setupConstraints() {
        let margin: CGFloat = 10
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),

            imageViewForCell.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageViewForCell.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageViewForCell.widthAnchor.constraint(equalToConstant: 50),
            imageViewForCell.heightAnchor.constraint(equalToConstant: 50),

            nameLabel.leadingAnchor.constraint(equalTo: imageViewForCell.trailingAnchor, constant: margin),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            typeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(viewModel: PokemonTableCellViewModel) {
        self.nameLabel.text = viewModel.title.capitalized
        viewModel.loadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.imageViewForCell.image = image
            }
        }
    }
}
