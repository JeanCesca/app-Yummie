//
//  OnboardingCollectionViewCell.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 17/10/22.
//

import Foundation
import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let id = "OnboardingCollectionViewCell"
    
    lazy var slideImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person.fill")
        image.clipsToBounds = true
        return image
    }()
    
    lazy var slideBigLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.text = "Entrega rápida na porta da sua casa"
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var slideSmallLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Yummie é delivery. {Yummie completar}"
        label.textColor = .systemGray3
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(slideImageView)
        contentView.addSubview(slideBigLabel)
        contentView.addSubview(slideSmallLabel)
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideBigLabel.text = slide.title
        slideSmallLabel.text = slide.description
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            slideImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            slideImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            slideImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height - 300),
            slideImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),

            slideBigLabel.topAnchor.constraint(equalTo: slideImageView.bottomAnchor, constant: 15),
            slideBigLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            slideBigLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            slideSmallLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            slideSmallLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            slideSmallLabel.topAnchor.constraint(equalTo: slideBigLabel.bottomAnchor, constant: 10),
//            slideSmallLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
