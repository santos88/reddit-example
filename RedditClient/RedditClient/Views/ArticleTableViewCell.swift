//
//  ArticleTableViewCell.swift
//  RedditClient
//
//  Created by Santos Ramon on 06-07-18.
//  Copyright © 2018 Santos Ramon. All rights reserved.
//

import UIKit

protocol ArticleCellProtocol:class {
    func remove(model:ArticleModel?)
}

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var unreadImage: UIImageView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!

    var articleModel:ArticleModel?
    weak var delegate:ArticleCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(model:ArticleModel) {
        
        articleModel = model
        usernameLabel.text = model.author
        timeLabel.text = model.created.description
        descriptionLabel.text = model.title
        commentsLabel.text = String(model.num_comments)
        if let wasRead = model.wasRead {
            unreadImage.isHidden = wasRead
        }
    }
    
    override func prepareForReuse() {
        unreadImage.isHidden = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func tapDismiss(_ sender: Any) {
        delegate?.remove(model: self.articleModel)
    }
}
