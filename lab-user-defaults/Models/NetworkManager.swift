//
//  NetworkManager.swift
//  lab-user-defaults
//
//  Created by Levi Davis on 9/24/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkManager {
    static let manager = NetworkManager()
    
    func performDataTask(url: URL, httpMethod: HTTPMethod, data: Data? = nil, completionHandler: @escaping (Result<Data, AppError>) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {completionHandler(.failure(.noDataReceived))
                    return }
                guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {completionHandler(.failure(.badStatusCode))
                    return }
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        completionHandler(.failure(.noInternetConnection))
                        return
                    } else {
                        completionHandler(.failure(.other(rawError: error)))
                    }
                }
                completionHandler(.success(data))
            }
            }.resume()
    }
    
    private init() {}
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
}

//enum HTTPMethod: String {
//    case get = "GET"
//    case post = "POST"
//}
//
//class NetworkManager {
//    static let manager = NetworkManager()
//
//    func performDataTask(url: URL, httpMethod: HTTPMethod, data: Data? = nil, completionHandler: @escaping (Result<Data, AppError>) -> () ) {
//
//        var request = URLRequest(url: url)
//        request.httpMethod = httpMethod.rawValue
//        request.httpBody = data
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        self.urlSession.dataTask(with: request) { (data, response, error) in
//            DispatchQueue.main.async {
//                guard let data = data else {completionHandler(.failure(.noDataReceived))
//                    return }
//                guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {completionHandler(.failure(.badStatusCode))
//                    return }
//                if let error = error {
//                    let error = error as NSError
//                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
//                        completionHandler(.failure(.noInternetConnection))
//                        return
//                    } else {
//                        completionHandler(.failure(.other(rawError: error)))
//                    }
//                }
//                completionHandler(.success(data))
//            }
//            }.resume()
//    }
//
//    private init() {}
//    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
//}
