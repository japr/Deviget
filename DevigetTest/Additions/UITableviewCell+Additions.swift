//
//  Placeholder.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import UIKit

protocol CellIdentifiable where Self: UITableViewCell {
    static func identifier() -> String
}

protocol ConfigurableCell where Self: UITableViewCell {
    associatedtype Element
    typealias DismissAction = (UITableViewCell) -> Void
    func configure(with item: Element, dismissAction: @escaping DismissAction)
}

extension UITableViewCell: CellIdentifiable {
    class func identifier() -> String {
        return String(describing: self) + "Identifier"
    }
}
