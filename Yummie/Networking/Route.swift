//
//  Route.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 21/10/22.
//

import Foundation

enum Route {
    
    static let baseURL = "https://yummie.glitch.me"
    
    case fetchAllCategories
    case placeOrder(String)
    case fetchCategory(String)
    case fetchOrders
    
    var description: String {
        switch self {
        case .fetchAllCategories:
            return "/dish-categories"
        case .placeOrder(let dishID):
            return "/orders/\(dishID)"
        case .fetchCategory(let categoryID):
            return "/dishes/\(categoryID)"
        case .fetchOrders:
            return "/orders"
        }
    }
}
