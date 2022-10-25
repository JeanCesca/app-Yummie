//
//  CategoriesCollectionView.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 18/10/22.
//

import Foundation
import UIKit
import ProgressHUD

protocol DishPortraitCollectionViewTableViewCellProtocol: AnyObject {
    func didSelectedDishCell(with model: Dish)
}

class DishPortraitCollectionViewTableViewCell: UITableViewCell {
    
    static let id = "DishPortraitCollectionViewTableViewCell"
    
    weak var delegate: DishPortraitCollectionViewTableViewCellProtocol?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DishPortraitCollectionViewCell.self, forCellWithReuseIdentifier: DishPortraitCollectionViewCell.id)
        return collectionView
    }()
    
    private var dishes: [Dish] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchAll()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    private func fetchAll() {
        ProgressHUD.show()
        APICaller.shared.fetchAllCategories { [weak self] result in
            switch result {
            case .success(let allDishes):
                ProgressHUD.dismiss()
                self?.dishes = allDishes.populars ?? []
                self?.collectionView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}

extension DishPortraitCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.id, for: indexPath) as? DishPortraitCollectionViewCell else { return UICollectionViewCell() }
        
        let model = dishes[indexPath.row]
        cell.setup(model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let model = dishes[indexPath.row]
        self.delegate?.didSelectedDishCell(with: model)
    }
}

extension DishPortraitCollectionViewTableViewCell: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width / 2, height: 320)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
        }
}
