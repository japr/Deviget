//
//  NetworkInterface.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badStatusCode
    case badURL
    case noData
    case noResponse
}

enum NetworkStatus {
    case notReachable
    case reachable
}

typealias NetworkStatusChangesCallback = (NetworkStatus) -> Void
typealias ResponseDataCallback = (Swift.Result<Data, Error>) -> Void

protocol NetworkInferface {
    func get(_ endpoint: Endpoint, _ callback: @escaping ResponseDataCallback)
    func get(_ url: String, _ callback: @escaping ResponseDataCallback)
}
