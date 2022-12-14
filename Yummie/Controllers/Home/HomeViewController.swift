//
//  ViewController.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 17/10/22.
//

import UIKit
import ProgressHUD

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
        table.separatorColor = .clear
        return table
    }()
    
    private var sections = [
        "Food Category",
        "Popular Dishes",
        "Chef's Special"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupView()
        setupItems()
        configureConstraints()
    }
    
    private func setupView() {
        title = "Yummie"
        view.backgroundColor = .systemBackground
    }
    
    private func setupItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart.circle.fill"), style: .plain, target: self, action: #selector(didTapCartButton))
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
    }
    
    @objc func didTapCartButton() {
        let vc = ListOrdersViewController()
        present(vc, animated: true, completion: nil)
    }
    
    private func configureConstraints() {
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
            return 130
        case Sections.Dish.rawValue:
            return 350
        case Sections.Landscape.rawValue:
            return 170
        default:
            return 140
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case Sections.Category.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCollectionViewTableViewCell.id, for: indexPath) as? CategoryCollectionViewTableViewCell else { return UITableViewCell() }
            
            cell.delegate = self
            return cell
            
        case Sections.Dish.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DishPortraitCollectionViewTableViewCell.id, for: indexPath) as? DishPortraitCollectionViewTableViewCell else { return UITableViewCell() }
            
            cell.delegate = self
            return cell
            
        case Sections.Landscape.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LandscapePortraitCollectionViewTableViewCell.id, for: indexPath) as? LandscapePortraitCollectionViewTableViewCell else { return UITableViewCell() }
            
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        header.textLabel?.textColor = .black        
    }
}

extension HomeViewController: CategoryCollectionViewTableViewCellProtocol {
    func didSelectedCategoryCell(with model: Category) {
        DispatchQueue.main.async {
            
            let vc = DishListViewController()
            vc.title = model.title
                        
            ProgressHUD.show()
            APICaller.shared.fetchDishList(categoryID: model.id ?? "") { result in
                switch result {
                case .success(let result):
                    ProgressHUD.dismiss()
                    vc.dishes = result
                    vc.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
                            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: DishPortraitCollectionViewTableViewCellProtocol {
    func didSelectedDishCell(with model: Dish) {
        DispatchQueue.main.async {
            
            let vc = FullDetailViewController()
            vc.title = model.name

            let viewModel = FullDetailViewModel(withModel: model)
            vc.configureView(with: viewModel)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: LandscapePortraitCollectionViewTableViewCellProtocol {
    func didSelectedLandscapeCell(with model: Dish) {
        DispatchQueue.main.async {
            
            let vc = FullDetailViewController()
            vc.title = model.name
            
            let viewModel = FullDetailViewModel(withModel: model)
            vc.configureView(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}




