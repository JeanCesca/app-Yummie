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
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Entrega rápida na porta da sua casa"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dishImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person.fill")
        image.clipsToBounds = true
        return image
    }()
    
    lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Entrega rápida na porta da sua casa"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Entrega rápida na porta da sua casa"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dishTitleLabel)
        contentView.addSubview(dishImageView)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(descriptionLabel)
        configureConstraints()
        
        contentView.backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(_ dish: Dish) {
        dishTitleLabel.text = dish.name
//        dishImageView.kf.setImage(with: dish.image?.asURL)
        caloriesLabel.text = dish.formattedCalories
        descriptionLabel.text = dish.description
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dishImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dishTitleLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 20),
            dishTitleLabel.centerYAnchor.constraint(equalTo: dishImageView.centerYAnchor),
            dishTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
