//
//  PostsDatasource.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import UIKit

class PostsDatasource<Element: Decodable, Cell: PostTableViewCell>: NSObject, UITableViewDataSource where Cell.Element == Element {
    
    var presenter: (UITableViewDelegate & PostTableViewCellDelegateInterface)?
    
    private(set) var items: [Element] = []
    
    func setItems(_ items: [Element]) {
        self.items = items
    }
    
    func itemAt(indexPath: IndexPath) -> Element {
        return items[indexPath.row]
    }
    
    func removeAllItems() {
        items = []
    }
      
    func removeItemAt(indexPath: IndexPath) {
        items.remove(at: indexPath.row)
    }
    
    func update(item: Element, at indexPath: IndexPath) {
        items[indexPath.row] = item
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier(), for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        
        guard let element = items[indexPath.item] as? Cell.Element else {
            return cell
        }
        
        cell.configure(with: element) { [weak self] cell in
            self?.presenter?.didTapDismissPost(cell: cell)
        }
        
        return cell
    }
}
