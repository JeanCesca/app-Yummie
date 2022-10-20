//
//  ViewController.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 17/10/22.
//

import UIKit

enum Sections: Int {
    case Category = 0
    case Dish = 1
    case Landscape = 2
}

class HomeViewController: UIViewController {
        
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CategoryCollectionViewTableViewCell.self, forCellReuseIdentifier: CategoryCollectionViewTableViewCell.id)
        table.register(DishPortraitCollectionViewTableViewCell.self, forCellReuseIdentifier: DishPortraitCollectionViewTableViewCell.id)
        table.register(LandscapePortraitCollectionViewTableViewCell.self, forCellReuseIdentifier: LandscapePortraitCollectionViewTableViewCell.id)
        return table
    }()
    
    private var sections = [
        "Food Category",
        "Popular Dishes",
        "Chef's Special"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Yummie"
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupItems()
        setupHomeView()
    }
    
    private func setupItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart.circle.fill"), style: .plain, target: self, action: #selector(didTapCartButton))
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
    }
    
    @objc func didTapCartButton() {
        
    }
    
    private func setupHomeView() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
            
        case Sections.Category.rawValue:
            return 100
            
        case Sections.Dish.rawValue:
            return 320
            
        case Sections.Landscape.rawValue:
            return 140
            
        default:
            return 140
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case Sections.Category.rawValue:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryCollectionViewTableViewCell.id, for: indexPath) as! CategoryCollectionViewTableViewCell
            
            return cell
            
        case Sections.Dish.rawValue:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: DishPortraitCollectionViewTableViewCell.id, for: indexPath) as! DishPortraitCollectionViewTableViewCell
            
            cell.delegate = self
            
            return cell
            
        case Sections.Landscape.rawValue:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LandscapePortraitCollectionViewTableViewCell.id, for: indexPath) as! LandscapePortraitCollectionViewTableViewCell
            
            cell.delegate = self
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
}

extension HomeViewController {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}

extension HomeViewController: DishPortraitCollectionViewTableViewCellProtocol {
    func didSelectedDishCell(with model: Dish) {
        DispatchQueue.main.async {
            
            let vc = FullDetailViewController()
            
            let viewModel = FullDetailViewModel(withModel: model)
            vc.configureView(with: viewModel)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension HomeViewController: LandscapePortraitCollectionViewTableViewCellProtocol {
    func didSelectedLandscapeCell() {
        DispatchQueue.main.async {
            
            let vc = FullDetailViewController()
            //            vc.configureView(with: landscapeModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}




