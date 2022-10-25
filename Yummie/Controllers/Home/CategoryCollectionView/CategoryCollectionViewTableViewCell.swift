//
//  CategoriesCollectionView.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 18/10/22.
//

import Foundation
import UIKit
import ProgressHUD

protocol CategoryCollectionViewTableViewCellProtocol: AnyObject {
    func didSelectedCategoryCell(with model: Category)
}

class CategoryCollectionViewTableViewCell: UITableViewCell {
        
    static let id = "CategoryCollectionViewTableViewCell"
    
    weak var delegate: CategoryCollectionViewTableViewCellProtocol?
        
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.id)
        return collectionView
    }()
    
    private var categories: [Category] = []
    
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
                self?.categories = allDishes.categories ?? []
                self?.collectionView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}

extension CategoryCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.id, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        
        let model = categories[indexPath.row]
        cell.updateCells(model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let model = categories[indexPath.row]
        
        let id = categories[indexPath.row].id
        
        self.delegate?.didSelectedCategoryCell(with: model)
    }
}

extension CategoryCollectionViewTableViewCell: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width / 2, height: 100)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
        }
}

