//
//  CategoriesCollectionView.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 18/10/22.
//

import Foundation
import UIKit

protocol DishPortraitCollectionViewTableViewCellProtocol: AnyObject {
    func didSelectedDishCell(with model: Dish)
}

class DishPortraitCollectionViewTableViewCell: UITableViewCell {
    
    static let id = "DishPortraitCollectionViewTableViewCell"
    
    weak var delegate: DishPortraitCollectionViewTableViewCellProtocol?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 220, height: 320)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DishPortraitCollectionViewCell.self, forCellWithReuseIdentifier: DishPortraitCollectionViewCell.id)
        return collectionView
    }()
    
    private var dishes: [Dish] = [
        Dish(id: "ID1", name: "Garri", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 32.5454),
        Dish(id: "ID1", name: "Jean", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 56.3233),
        Dish(id: "ID1", name: "Yann", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 12.4444),
        Dish(id: "ID1", name: "Paula", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 90.0000),
        Dish(id: "ID1", name: "René", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 100.3333)
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
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        let model = dishes[indexPath.row]
        cell.setup(model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = dishes[indexPath.row]
        self.delegate?.didSelectedDishCell(with: model)
    }
}
