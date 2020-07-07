//
//  ServiceClient.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation


protocol ServiceClient {
    /// A generic function to use when fetching data from a url
    /// - Parameters:
    ///   - url: The endpoint to get data from
    ///   - completion: Response from the service call in the form of a `Result<T, ServiceError>` with a ServiceError obect
    func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, ServiceError>) -> Void)
}

extension ServiceClient {
    func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, ServiceError>) -> Void) {
        
        let internetReachability = Reachability()
        
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidURL))
            return
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        
        if !internetReachability.isInternetAvailable() {
            completion(.failure(.networkError))
        }
        
        URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                    200..<299 ~= statusCode else {
                        completion(.failure(.requestFailed))
                        return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let value = try decoder.decode(T.self, from: data)
                    completion(.success(value))
                } catch let error {
                    print(error)
                    completion(.failure(.decodeError))
                }
                
            case .failure(_):
                completion(.failure(.requestFailed))
            }
        }.resume()
        
    }
    
}

