//
//  DetailViewController.swift
//  RedditClient
//
//  Created by Santos Ramon on 06-07-18.
//  Copyright © 2018 Santos Ramon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var article:ArticleModel?

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        self.usernameLabel.text = article?.author
        self.descriptionLabel.text = article?.title
    }
}

