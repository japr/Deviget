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
        datasource.presenter = self
        dismissButton = dismissAllButton
        dismissAllButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        tableView = table
        tableView.dataSource = datasource
        tableView.delegate = self
        loadTopPosts()
    }
    
    @objc
    private func dismissButtonTapped() {
        datasource.removeAllItems()
        tableView.reloadData()
    }
}

extension MasterPresenter: PostTableViewCellDelegateInterface {
    func didTapDismissPost(cell: UITableViewCell) {
        guard let index = tableView.indexPath(for: cell) else {
            return
        }
        tableView.beginUpdates()
        datasource.removeItemAt(indexPath: index)
        tableView.deleteRows(at: [index], with: .top)
        tableView.endUpdates()
    }
}

extension MasterPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var post = datasource.itemAt(indexPath: indexPath)
        post.unread = false
        tableView.beginUpdates()
        datasource.update(item: post, at: indexPath)
        tableView.reloadRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
        wireframe?.showDetailsFor(post: post)
    }
}
