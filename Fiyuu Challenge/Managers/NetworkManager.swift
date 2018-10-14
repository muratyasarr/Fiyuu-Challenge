//
//  NetworkManager.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import Foundation

import UIKit

// Types
enum Result<T> {
    case success(T)
    case error(Error)
}

typealias ResultCallback<T> = (Result<T>) -> Void

enum NetworkStackError: Error {
    case invalidRequest
    case dataMissing
}


// Webservice
protocol WebserviceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping ResultCallback<T>)
}

class NetworkManager: WebserviceProtocol {
    
    private let urlSession: URLSession
    private let parser: Parser
    
    init(urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.urlSession = urlSession
        self.parser = Parser()
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping ResultCallback<T>) {
        
        guard let request = endpoint.request else {
            OperationQueue.main.addOperation({ completion(.error(NetworkStackError.invalidRequest)) })
            return
        }
        
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            debugPrint([request, response])
            if let error = error {
                OperationQueue.main.addOperation({ completion(.error(error)) })
                return
            }
            
            guard let data = data else {
                OperationQueue.main.addOperation({ completion(.error(NetworkStackError.dataMissing)) })
                return
            }
            self.parser.json(data: data, completion: completion)
        }
        
        task.resume()
    }
}

struct Parser {
    let jsonDecoder = JSONDecoder()
    func json<T: Decodable>(data: Data, completion: @escaping ResultCallback<T>) {
        do {
            let fiyuuResponseModel = try? jsonDecoder.decode(T.self, from: data)
            OperationQueue.main.addOperation { completion(.success(fiyuuResponseModel!)) }
        } catch let parseError {
            OperationQueue.main.addOperation { completion(.error(parseError)) }
        }
    }
}


// Endpoint
protocol Endpoint {
    var request: URLRequest? { get }
    var httpMethod: String { get }
    var queryItems: [URLQueryItem]? { get }
    var requestHeaders: [String: String]? { get }
    var requestBody: Data? { get }
    var scheme: String { get }
    var host: String { get }
}

extension Endpoint {
    func request(forPath path: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = requestBody
        if let headers = requestHeaders {
            for (key,value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}

// BrandsEndpoint
enum BrandsEndpoint {
    case all
    case details(brandId: String)
}

extension BrandsEndpoint: Endpoint {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api-dev.fiyuu.com.tr"
    }
    
    var request: URLRequest? {
        switch self {
        case .details(brandId: _):
            return request(forPath: "/customer/product/getBrandDetails2")
        case .all:
            return request(forPath: "/customer/product/scanBrands-1.0")
        }
    }
    
    var httpMethod: String {
        switch self {
        case .details(brandId: _):
            return "POST"
        case .all:
            return "POST"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        let defaultQueryItems: [URLQueryItem] = []
        switch self {
        case .details(let brandId):
            let detailsQueryItems = defaultQueryItems + [URLQueryItem(name: "brandId", value: brandId)]
            return detailsQueryItems
        case .all:
            return defaultQueryItems
        }
    }
    
    var requestHeaders: [String: String]? {
        let defaultHeaders = [
            "token": "XpcLEEIMqSuRiDlCkww0sww82NTx5fyRE3y5UOxA3mnSlA4/ySgTpAAEa67fKuBcoiLmjO3K8upOmZxNp2IXIxZSCf6twi67bOsUb5DLAsvi1OXPhLkwbL7pzYwb9vZc/Vlhcr+czKIz7HUpQpH8JKiQUw=="
        ]
        switch self {
        case .all:
            return defaultHeaders
        case .details(brandId: _):
            return defaultHeaders
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .all:
            return nil
        case .details(let brandId):
            let bodyDict = ["brandId": brandId]
            guard let bodyData = try? JSONSerialization.data(withJSONObject: bodyDict, options: .prettyPrinted) else { return nil }
            return bodyData
        }
    }
}
