//
//  MasterPresenter.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import UIKit

class MasterPresenter: NSObject {
    private let datasource: PostsDatasource<RedditPost, PostTableViewCell>
    private var dismissButton: UIButton!
    private let redditTopRepository: RedditTopRepositoryInterface
    private var tableView: UITableView!
        
    var wireframe: MasterWireframeInterface?
    
    init(repository: RedditTopRepositoryInterface,
         wireframe: MasterWireframeInterface) {
        self.datasource = PostsDatasource()
        self.redditTopRepository = repository
        self.wireframe = wireframe
    }
    
    private func loadTopPosts() {
        redditTopRepository.retrieveTopPosts { [unowned self] result in
            switch result {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let list):
                self.datasource.setItems(list)
                self.tableView.reloadData()
            }
        }
    }
    
    func registerInputs(table: UITableView, dismissAllButton: UIButton) {
        dismissButton = dismissAllButton
        dismissAllButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        tableView = table
        tableView.dataSource = datasource
        loadTopPosts()
    }
    
    @objc
    private func dismissButtonTapped() {
        
    }
}
