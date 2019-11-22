//
//  PostCollectionViewCell.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import UIKit

protocol PostTableViewCellDelegateInterface {
    func didTapDismissPost(cell: UITableViewCell)
}

class PostTableViewCell: UITableViewCell {
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var dismissButton: UIButton!
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var unreadIndicator: UIView!
    
    private(set) var action: DismissAction!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        unreadIndicator.backgroundColor = UIColor.blue
        unreadIndicator.layer.cornerRadius = unreadIndicator.frame.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorLabel.text = nil
        commentsLabel.text = nil
        title.text = nil
    }
    
    @IBAction private func dismissButtonTapped(_ sender: UIButton) {
        action(self)
    }
}

extension PostTableViewCell: ConfigurableCell {

    typealias Element = RedditPost
    
    func configure(with item: RedditPost, dismissAction: @escaping DismissAction) {
        action = dismissAction
        authorLabel.text = item.author
        commentsLabel.text = "\(item.numberOfComments) comments"
        title.text = item.title
        unreadIndicator.isHidden = !item.unread
    }
}
