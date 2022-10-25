//
//  DishListViewController.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 20/10/22.
//

import Foundation
import UIKit
import ProgressHUD

class DishListViewController: UIViewController {
        
    public var dishes: [Dish] = []
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DishListTableViewCell.self, forCellReuseIdentifier: DishListTableViewCell.id)
        table.separatorColor = .clear
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureConstraints()
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

extension DishListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.id, for: indexPath) as? DishListTableViewCell else { return UITableViewCell() }
        
        let model = dishes[indexPath.row]
//        let viewModel = DishListViewModel(withModel: model)
        
        cell.configureView(model)
        cell.applyShadow(cornerRadius: 10)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        DispatchQueue.main.async { [weak self] in
            
            let vc = FullDetailViewController()
            
            let model = self?.dishes[indexPath.row]
            let optionalModel = Dish(id: "", name: "", description: "", image: "", calories: 0)
            
            let viewModel = FullDetailViewModel(withModel: model ?? optionalModel)
            
            vc.configureView(with: viewModel)
            vc.title = model?.name
        
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

