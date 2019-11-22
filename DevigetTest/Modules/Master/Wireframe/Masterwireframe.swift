//
//  Masterwireframe.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import Foundation

protocol MasterWireframeInterface {
    func showDetailsFor(post: RedditPost)
}

class MasterWireframe {
    var detailsViewController: DetailsViewController?
}

extension MasterWireframe: MasterWireframeInterface {
    func showDetailsFor(post: RedditPost) {
        detailsViewController?.updateDetailsWith(post: post)
    }
}
