//
//  DishListViewModel.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 20/10/22.
//

import Foundation
import ProgressHUD

class DishListViewModel {
    
    var model: Dish
    
    init(withModel model: Dish) {
        self.model = model
    }
    
    var id: String {
        return model.id ?? String.emptyString
    }

    var image: String {
        return model.image ?? String.emptyString
    }
    
    var name: String {
        return model.name ?? String.emptyString
    }
    
    var description: String {
        return model.description ?? String.emptyString
    }
    
//    private func networkService(with model: Dish) {
//        ProgressHUD.show()
//        APICaller.shared.fetchDishList(categoryID: id) { [weak self] result in
//            switch result {
//            case .success(let dishList):
//                ProgressHUD.dismiss()
//                self?.model = dishList
//            case .failure(let error):
//                ProgressHUD.showError(error.localizedDescription)
//            }
//        }
//    }
}
