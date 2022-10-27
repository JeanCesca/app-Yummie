//
//  FullDetailViewModel.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 19/10/22.
//

import Foundation
import ProgressHUD

class FullDetailViewModel {
    
    var model: Dish
    
    init(withModel model: Dish? = nil) {
        self.model = model ?? Dish(id: "", name: "", description: "", image: "", calories: 0)
    }
    
    var id: String {
        return model.id ?? String.emptyString
    }
    
    var name: String {
        return model.name ?? String.emptyString
    }
    
    var description: String {
        return model.description ?? String.emptyString
    }
    
    var image: String {
        return model.image ?? String.emptyString
    }
    
    var calories: String {
        return String(format: "%.2f calories", model.calories ?? 0.0)
    }
}
