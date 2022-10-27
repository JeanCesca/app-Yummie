//
//  ListOrdersViewController.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 21/10/22.
//

import Foundation
import UIKit
import ProgressHUD

class ListOrdersViewController: UIViewController {
    
    var orders: [Order] = []
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProgressHUD.show()
        fetchOrder()
    }
    
    private func fetchOrder() {
        APICaller.shared.fetchOrders { [weak self] result in
            switch result {
            case .success(let orders):
                ProgressHUD.dismiss()
                self?.orders = orders
                self?.tableView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
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

extension ListOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.id, for: indexPath) as? DishListTableViewCell else { return UITableViewCell() }
        
        let model = orders[indexPath.row]
        cell.setup(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
