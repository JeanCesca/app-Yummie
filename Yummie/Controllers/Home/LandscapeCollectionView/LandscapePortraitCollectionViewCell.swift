//
//  DishPortraitCollectionViewCell.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 19/10/22.
//

import Foundation
import UIKit
import Kingfisher

class LandscapePortraitCollectionViewCell: UICollectionViewCell {
    
    static let id = "LandscapePortraitCollectionViewCell"
    
    lazy var landscapeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person.fill")
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
    
    lazy var landscapeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Label"
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var landscapeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Label"
        label.textColor = .systemGray3
        label.numberOfLines = 0
        return label
    }()
    
    lazy var landscapeCalorieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Label"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemBackground
        contentView.applyShadow(cornerRadius: 10)
        
        contentView.addSubview(landscapeImageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(landscapeTitleLabel)
        stackView.addArrangedSubview(landscapeDescriptionLabel)
        stackView.addArrangedSubview(landscapeCalorieLabel)
        configureConstraints()
        
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(_ dish: Dish) {
        landscapeTitleLabel.text = dish.name
        landscapeImageView.kf.setImage(with: dish.image?.asURL)
        landscapeCalorieLabel.text = dish.formattedCalories
        landscapeDescriptionLabel.text = dish.description
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            landscapeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            landscapeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            landscapeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            landscapeImageView.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.leadingAnchor.constraint(equalTo: landscapeImageView.trailingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: landscapeImageView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: landscapeImageView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            landscapeDescriptionLabel.leadingAnchor.constraint(equalTo: landscapeImageView.trailingAnchor, constant: 20),
            landscapeDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

        ])
    }
}
    
    
