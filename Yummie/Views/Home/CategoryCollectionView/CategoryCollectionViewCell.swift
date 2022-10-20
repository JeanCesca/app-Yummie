//
//  FoodCollectionViewCell.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 18/10/22.
//

import Foundation
import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let id = "FoodCollectionViewCell"
    
    lazy var categoryImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person.fill")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "Entrega rápida na porta da sua casa"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryTitleLabel)
        configureConstraints()
        
        contentView.backgroundColor = .systemBackground
        contentView.applyShadow(cornerRadius: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(_ category: Category) {
        categoryTitleLabel.text = category.name
        categoryImageView.kf.setImage(with: category.image?.asURL)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            categoryImageView.widthAnchor.constraint(equalToConstant: 60),
            
            categoryTitleLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 20),
            categoryTitleLabel.centerYAnchor.constraint(equalTo: categoryImageView.centerYAnchor),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
