//
//  DishPortraitCollectionViewTableViewCell.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 19/10/22.
//

import Foundation
import UIKit

protocol LandscapePortraitCollectionViewTableViewCellProtocol: AnyObject {
    func didSelectedLandscapeCell(with model: Dish)
}

class LandscapePortraitCollectionViewTableViewCell: UITableViewCell {
    
    static let id = "LandscapePortraitCollectionViewTableViewCell"
    
    weak var delegate: LandscapePortraitCollectionViewTableViewCellProtocol?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(LandscapePortraitCollectionViewCell.self, forCellWithReuseIdentifier: LandscapePortraitCollectionViewCell.id)
        return collectionView
    }()
    
    private var dishes: [Dish] = [
        Dish(id: "ID1", name: "Fried Plantain", description: "This is my favourite dish.", image: "https://picsum.photos/100/200", calories: 32.5454),
        Dish(id: "ID1", name: "Beans and Garri", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 56.3233),
        Dish(id: "ID1", name: "Yann", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 12.4444),
        Dish(id: "ID1", name: "Paula", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 90.0000),
        Dish(id: "ID1", name: "René", description: "This is the best I have ever tasted.", image: "https://picsum.photos/100/200", calories: 100.3333)
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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

extension LandscapePortraitCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LandscapePortraitCollectionViewCell.id, for: indexPath) as! LandscapePortraitCollectionViewCell
        
        let model = dishes[indexPath.row]
        cell.setup(model)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let model = dishes[indexPath.row]
        self.delegate?.didSelectedLandscapeCell(with: model)
    }
}

extension LandscapePortraitCollectionViewTableViewCell: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width / 1.2, height: 140)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
        }
}


