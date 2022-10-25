//
//  Order.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 21/10/22.
//

import Foundation

struct Order: Codable {
    let id: String?
    let name: String?
    let dish: Dish?
}
