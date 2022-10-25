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
        
        let optionalDish = Dish(
            id: "",
            name: "",
            description: "",
            image: "",
            calories: 0
        )
        
        self.model = model ?? optionalDish
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
    
    func networkService(with textField: UITextField) {
        guard let name = textField.text?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty
        else {
            ProgressHUD.showError("Please enter your name!")
            return }
        
        ProgressHUD.show("Placing Order...")
        
        APICaller.shared.placeOrder(dishID: id, name: name) { result in
            switch result {
            case .success(_):
                ProgressHUD.showSuccess("Sucesso")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}
