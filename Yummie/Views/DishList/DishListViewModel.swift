//
//  DishListViewModel.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 20/10/22.
//

import Foundation

class DishListViewModel {
    
    var model: Category
    
    init(withModel model: Category) {
        self.model = model
    }
    
    var id: String {
        return model.id ?? String.emptyString
    }
    
    var name: String {
        return model.name ?? String.emptyString
    }
    
    var image: String {
        return model.image ?? String.emptyString
    }

}
