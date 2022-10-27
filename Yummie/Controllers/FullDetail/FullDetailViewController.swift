//
//  FullDetailPageViewController.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 19/10/22.
//

import Foundation
import UIKit
import ProgressHUD

class FullDetailViewController: UIViewController {
    
    var model: FullDetailViewModel!
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 25
        return stackView
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your name"
        textField.backgroundColor = .systemBackground
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    lazy var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Place Order", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        view.addSubview(verticalStackView)
        view.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(caloriesLabel)
    
        view.addSubview(descriptionLabel)
        
        verticalStackView.addArrangedSubview(textField)
        verticalStackView.addArrangedSubview(orderButton)

        configureConstraints()
        actions()
    }
    
    private func actions() {
        orderButton.addTarget(self, action: #selector(didTapOrderButton), for: .touchUpInside)
    }
    
    @objc private func didTapOrderButton() {
        networkService()
    }
    
    func networkService() {
        guard let name = textField.text?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty
        else {
            ProgressHUD.showError("Please enter your name!")
            return }
                
        ProgressHUD.show("Placing Order...")
        APICaller.shared.placeOrder(dishID: model.id, name: name) { result in
            switch result {
            case .success(_):
                ProgressHUD.showSuccess("Sucesso")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
        
    public func configureView(with viewModel: FullDetailViewModel) {
        imageView.kf.setImage(with: viewModel.image.asURL)
        titleLabel.text = viewModel.name
        caloriesLabel.text = viewModel.calories
        descriptionLabel.text = viewModel.description
        
        self.model = viewModel
    }
    
    private func configureConstraints() {
                
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: verticalStackView.topAnchor, constant: -20),
            
            orderButton.heightAnchor.constraint(equalToConstant: 60),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            horizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -20)
        ])
        
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
