//
//  DishListTableViewCell.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 20/10/22.
//

import Foundation
import UIKit

class DishListTableViewCell: UITableViewCell {
    
    static let id = "DishListTableViewCell"
    
    lazy var dishImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray3
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.applyShadow(cornerRadius: 10)

        contentView.addSubview(dishImageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureView(_ model: Dish) {
        dishImageView.kf.setImage(with: model.image?.asURL)
        titleLabel.text = model.name
        descriptionLabel.text = model.description
    }
    
    public func setup(_ model: Order) {
        dishImageView.kf.setImage(with: model.dish?.image?.asURL)
        titleLabel.text = model.name
        descriptionLabel.text = model.dish?.description
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dishImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            dishImageView.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: dishImageView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    
    
}
