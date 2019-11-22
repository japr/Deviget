//
//  UIImageView+Additions.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageFrom(url: String) {
        NetworkManager.default.get(url) { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error loading image: ", error)
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    return
                }
                self?.image = image
            }
        }
    }
}
