//
//  NetworkManager.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import Foundation

class NetworkManager {

    private let environment: Environment
    private let session: URLSession

    static let `default` = NetworkManager()

    init(environment: Environment = .dev, session: URLSession = .shared) {
        self.environment = environment
        self.session = session
    }
}

extension NetworkManager: NetworkInferface {
    func get(_ endpoint: Endpoint, _ callback: @escaping ResponseDataCallback) {
        let fullPath = environment.path+endpoint.path
        get(fullPath, callback)
    }
    
    func get(_ url: String, _ callback: @escaping ResponseDataCallback) {
        guard let url = URL(string: url) else {
            callback(.failure(NetworkError.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30.0
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    callback(.failure(NetworkError.noResponse))
                    return
                }
                let responseCode = httpResponse.statusCode
                guard (200...299).contains(responseCode) else {
                    callback(.failure(NetworkError.badStatusCode))
                    return
                }
                
                guard let dataResponse = data else {
                    callback(.failure(NetworkError.noData))
                    return
                }
                callback(.success(dataResponse))
            }
        }
        task.resume()
    }
}
