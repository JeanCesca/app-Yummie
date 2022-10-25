//
//  OpeningViewController.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 17/10/22.
//

import UIKit

class OpeningViewController: UIViewController {
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "appIcon")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Yummie"
        label.font = .systemFont(ofSize: 34, weight: .medium)
        label.textColor = .systemRed
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
                
        view.addSubview(logoImage)
        view.addSubview(logoLabel)
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 150),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            
            logoLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            logoLabel.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor)
        ])
    }
}
