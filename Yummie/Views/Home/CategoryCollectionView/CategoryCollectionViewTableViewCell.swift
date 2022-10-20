//
//  CategoriesCollectionView.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 18/10/22.
//

import Foundation
import UIKit


class CategoryCollectionViewTableViewCell: UITableViewCell {
        
    static let id = "CollectionViewTableViewCell"
        
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 220, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.id)
        collectionView.backgroundColor = .systemGray4
        return collectionView
    }()
    
    private var categories: [Category] = [
        Category(id: "ID1", name: "Africa", image: "https://picsum.photos/100/200"),
        Category(id: "ID1", name: "Africa", image: "https://picsum.photos/100/200"),
        Category(id: "ID1", name: "Africa", image: "https://picsum.photos/100/200"),
        Category(id: "ID1", name: "Africa", image: "https://picsum.photos/100/200"),
        Category(id: "ID1", name: "Africa", image: "https://picsum.photos/100/200"),
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemPink
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

extension CategoryCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.id, for: indexPath) as! CategoryCollectionViewCell
        
        let model = categories[indexPath.row]
        cell.setup(model)
        
        cell.layer.cornerRadius = 10
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
}

