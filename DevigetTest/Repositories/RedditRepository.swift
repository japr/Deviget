//
//  RedditRepository.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import Foundation

enum RedditTopRepositoryError: Error {
    case deserializationFailed
    case networkCallFailed
}

typealias RedditTopResponseCallback = (Swift.Result<[RedditPost], RedditTopRepositoryError>) -> Void

protocol RedditTopRepositoryInterface {
    func retrieveTopPosts(callBack: @escaping RedditTopResponseCallback)
}

class RedditTopRepository {
    private let network: NetworkInferface
    
    init(network: NetworkInferface = NetworkManager.default) {
        self.network = network
    }
}

extension RedditTopRepository: RedditTopRepositoryInterface {
    func retrieveTopPosts(callBack: @escaping RedditTopResponseCallback) {
        network.get(.top) { result in
            switch result {
            case .failure(_):
                callBack(.failure(.networkCallFailed))
            case .success(let data):
                do {
                    let list = try JSONDecoder().decode(RedditList.self, from: data)
                    callBack(.success(list.posts))
                } catch {
                    callBack(.failure(.deserializationFailed))
                }
            }
        }
    }
}
