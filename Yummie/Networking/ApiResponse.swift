//
//  ApiResponse.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 24/10/22.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
