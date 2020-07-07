//
//  URLSession+Extension.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//


import Foundation

extension URLSession {
    
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            
            result(.success((response, data)))
        })
    }
    
    func dataTask(with request: URLRequest, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            
            result(.success((response, data)))
        })
    }
}


extension Data {
    
    func act_description() -> String? {
        return String(data: self, encoding: .utf8)
    }

    /// Returns valid JSON string id possible
    func act_JSONString() -> NSString? {

        guard let _ = try? JSONSerialization.jsonObject(with: self, options: []) else {
            return nil // data cannot be deserialized, invalid JSON
        }

        guard let str = String(data: self, encoding: .utf8) else {
            return nil // data to string conversation failed
        }

        // NSString conversion necessary, Swift.String is an escaped string ):
        return NSString(string: str)
    }
}
