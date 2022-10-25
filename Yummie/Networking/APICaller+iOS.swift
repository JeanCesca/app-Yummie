//
//  APICaller+iOS.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 21/10/22.
//

import Foundation

class APICalleriOS {
    
    static let shared = APICalleriOS()
        
    public func performRequest<T: Codable>(
        url: String,
        expectingReturnType: T.Type,
        completion: @escaping ((Result<T, Error>) -> Void)) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else { return }
        
            var decodedResult: T?
            
            do {
                decodedResult = try JSONDecoder().decode(T.self, from: data)
                guard let decodedResult = decodedResult else {
                    return
                }
                completion(.success(decodedResult))
            } catch let error {
                decodedResult = nil
                print(error)
            }
        }.resume()
    }
}
