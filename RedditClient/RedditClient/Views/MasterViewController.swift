//
//  MasterViewController.swift
//  RedditClient
//
//  Created by Santos Ramon on 06-07-18.
//  Copyright © 2018 Santos Ramon. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, ArticleCellProtocol {
    
    var detailViewController: DetailViewController? = nil
    var controller = ArticlesController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchArticles()
    }

    func configureUI() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

        let addButton: UIBarButtonItem = UIBarButtonItem(title: "Dismiss All", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.dismisAll(_:)))
        
        navigationItem.rightBarButtonItem = addButton
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        fetchArticles()
    }
    
    func fetchArticles() {
        controller.loadArticles { [weak self] (articles, error) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc func dismisAll(_ button:UIBarButtonItem!){
        controller.removeAllArticles()
        tableView.reloadData()
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.cache.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell

        let model = controller.cache[indexPath.row]
        cell.configure(model: model)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.articleWasReadAtIndex(row: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func remove(model: ArticleModel?) {
        if let article = model {
            controller.remove(article: article)
            tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let model = controller.cache[indexPath.row]
                let vc = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                vc.article = model
                vc.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                vc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

}

