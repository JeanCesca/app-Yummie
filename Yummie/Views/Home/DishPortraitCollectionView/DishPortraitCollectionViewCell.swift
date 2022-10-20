//
//  DishPortraitCollectionViewCell.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 18/10/22.
//

import Foundation
import UIKit
import Kingfisher

class DishPortraitCollectionViewCell: UICollectionViewCell {
    
    static let id = "DishPortraitCollectionViewCell"
    
    lazy var dishTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "Label"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dishImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person.fill")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Label"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Label"
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemBackground
        contentView.applyShadow(cornerRadius: 10)
        
        contentView.addSubview(dishTitleLabel)
        contentView.addSubview(dishImageView)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(descriptionLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(_ dish: Dish) {
        dishTitleLabel.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asURL)
        caloriesLabel.text = (dish.formattedCalories)
        descriptionLabel.text = dish.description
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            dishTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dishTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            dishTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            
            dishImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dishImageView.topAnchor.constraint(equalTo: dishTitleLabel.bottomAnchor),
            dishImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width - 40),
            dishImageView.heightAnchor.constraint(equalToConstant: 200),

            caloriesLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 10),
            caloriesLabel.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: caloriesLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
