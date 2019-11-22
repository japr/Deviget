//
//  APO.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import Foundation

protocol EnvironmentPath {
    var path: String { get }
}

enum Environment {
    case dev
}

extension Environment: EnvironmentPath {
    var path: String {
        switch self {
        case .dev:  return "https://www.reddit.com"
        }
    }
}

protocol EndpointPath {
    var path: String { get }
}

enum Endpoint {
    case top
}

extension Endpoint: EndpointPath {
    var path: String {
        switch self {
        case .top: return "/top.json"
        }
    }
}
