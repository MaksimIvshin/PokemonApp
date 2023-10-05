//
//  MainPokemonCell.swift
//  PokemonApp
//
//  Created by Maks Ivshin on 30.09.23.
//
import UIKit

class MainPokemonCell: UITableViewCell {
    // Constant for the MainPokemonCell.
    public static var indetifier: String {
        get{
            return "MainPokemonCell"
        }
    }
    // Creating UI elements.
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
    // Initiliztion.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
        setupCell()
    }
    // Add views to the MainPokemonCell.
    func addViews() {
        containerView.addSubview(nameLabel)
        contentView.addSubview(containerView)
    }
    // Some configuration.
    func setupCell() {
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell(viewModel: PokemonTableCellViewModel) {
        self.nameLabel.text = viewModel.title.capitalized
    }
}

extension MainPokemonCell {
    // Positioning and layout constraints for the UI elements
    func setupConstraints() {
        let margin: CGFloat = 10
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
        ])
    }
}
