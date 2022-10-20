//
//  DishListViewController.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 20/10/22.
//

import Foundation
import UIKit

class DishListViewController: UIViewController {
        
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DishListTableViewCell.self, forCellReuseIdentifier: DishListTableViewCell.id)
        table.separatorColor = .clear
        return table
    }()
    
    private var dishes: [Dish] = [
        Dish(id: "ID1", name: "Fried Plantain", description: "This is my favourite dish.", image: "https://picsum.photos/100/200", calories: 32.5454),
        Dish(id: "ID1", name: "Beans and Garri", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 56.3233),
        Dish(id: "ID1", name: "Yann", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 12.4444),
        Dish(id: "ID1", name: "Paula", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 90.0000),
        Dish(id: "ID1", name: "René", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 100.3333)
    ]
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.id, for: indexPath) as! DishListTableViewCell
        
        let model = dishes[indexPath.row]
        cell.setup(model)
        cell.applyShadow(cornerRadius: 10)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let model = dishes[indexPath.row]

    }
}

