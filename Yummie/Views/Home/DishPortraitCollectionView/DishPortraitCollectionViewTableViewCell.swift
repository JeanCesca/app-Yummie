//
//  CategoriesCollectionView.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 18/10/22.
//

import Foundation
import UIKit

class DishPortraitCollectionViewTableViewCell: UITableViewCell {
    
    static let id = "CollectionViewTeste"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 220, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DishPortraitCollectionViewCell.self, forCellWithReuseIdentifier: DishPortraitCollectionViewCell.id)
        return collectionView
    }()
    
    private var dishes: [Dish] = [
        Dish(id: "", name: "", description: "", image: "", calories: 0.0),
        Dish(id: "", name: "", description: "", image: "", calories: 0.0),
        Dish(id: "", name: "", description: "", image: "", calories: 0.0),
        Dish(id: "", name: "", description: "", image: "", calories: 0.0),
        Dish(id: "", name: "", description: "", image: "", calories: 0.0)
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray3
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
}

extension DishPortraitCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.id, for: indexPath) as! DishPortraitCollectionViewCell
        
        let model = dishes[indexPath.row]
        cell.setup(model)
        
        return cell
    }
}
