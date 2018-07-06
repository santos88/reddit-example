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
    var imageFromUrlTask: URLSessionDataTask?
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
        loadImage()
    }
    
    // TODO: THIS METHOD SHOULD BE MOVED INTO OTHER CLASS
    func loadImage() {
        guard let stringURL = article?.thumbnail, let imageURL = URL(string:stringURL) else {
            return;
        }
        
        let session = URLSession(configuration: .default)
        imageFromUrlTask = session.dataTask(with: imageURL) { (data, response, error) in
            if let e = error {
                print("Error Occurred: \(e)")
                
            } else {
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.mainImage.image = image
                        }
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        imageFromUrlTask?.resume()
    }

}

