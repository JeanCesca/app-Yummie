//
//  APICaller.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 21/10/22.
//

import Foundation

struct APICaller {

    static let shared = APICaller()

    private init() {}
    
    func placeOrder(dishID: String, name: String, completion: @escaping(Result<Order, Error>) -> Void) {
        let params = ["name": name]
        makeRequest(route: Route.placeOrder(dishID), method: .post, parameters: params, completion: completion)
    }
    
    func fetchOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        makeRequest(route: .fetchOrders, method: .get, completion: completion)
    }
    
    func fetchDishList(categoryID: String, completion: @escaping(Result<[Dish], Error>) -> Void) {
        makeRequest(route: .fetchCategory(categoryID), method: .get, completion: completion)
    }
    
    func fetchAllCategories(completion: @escaping(Result<AllDishes, Error>) -> Void) {
        makeRequest(route: .fetchAllCategories, method: .get, completion: completion)
    }

    private func makeRequest<T: Codable>(
        route: Route,
        method: Method,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<T, Error>) -> Void) {

            guard let request = createRequest(route: route, method: method, parameters: parameters) else {
                completion(.failure(AppError.unknownError))
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                
                var result: Result<Data, Error>?

                guard let data = data, error == nil else {
                    completion(.failure(AppError.serverError("No data :(")))
                    return
                }
                
                result = .success(data)

                DispatchQueue.main.async {
                    self.handleResponse(result: result, completion: completion)
                }

            }.resume()
    }

    private func handleResponse<T:Codable>(result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }

        switch result {

        case .success(let data):
            let decoder = JSONDecoder()

            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }

            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }

            if let decodedData = response.data {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.unknownError))
            }

        case .failure(let error):
            completion(.failure(error))
        }

    }

    private func createRequest(
        route: Route,
        method: Method,
        parameters: [String: Any]? = nil) -> URLRequest? {

        let urlString = Route.baseURL + route.description
        guard let url = URL(string: urlString) else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue

        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url

            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }

        return urlRequest
    }
}
