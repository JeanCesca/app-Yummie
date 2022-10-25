//
//  AppError.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 24/10/22.
//

import Foundation

enum AppError: LocalizedError {
    
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Bruuuuh! I have no ideia ideia what go on"
        case . invalidUrl:
            return "HEEYY. Give me a valid url!"
        case .serverError(let error):
            return error
        }
    }
}
