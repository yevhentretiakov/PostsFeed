//
//  ViewController.swift
//  PostsFeed
//
//  Created by user on 30.06.2022.
//

import UIKit

class FeedVC: UIViewController {
    
    @IBOutlet private weak var feedTableView: UITableView!
    
    var posts: [Post] = [
        Post(title: "Post 1", body: "Lorem ipsum is placeholder text commonly used in.", likes: "1240", date: "18 day ago"),
        Post(title: "Post 2", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", likes: "421", date: "21 day ago")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Feed"
        
        configureFeedTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func configureFeedTableView() {
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        feedTableView.register(UINib.init(nibName: PostCell.reuseID, bundle: nil), forCellReuseIdentifier: PostCell.reuseID)
    }
    
    @IBAction private func filterTapped(_ sender: UIBarButtonItem) {
        
        print("Filter")
    }
    
    @objc func expandButtonTapped(sender: UIButton) {
        
        let tag = sender.tag
        posts[tag].isExpanded.toggle()
        
        let indexPath = IndexPath(row: tag, section: 0)
        
        feedTableView.reloadRows(at: [indexPath], with: .none)
    }
}

// MARK: - FeedTableView Delegate & DataSource
extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = feedTableView.dequeueReusableCell(withIdentifier: PostCell.reuseID) as! PostCell
        
        let post = posts[indexPath.row]
        cell.set(post: post)
        
        cell.expandButton.tag = indexPath.row
        cell.expandButton.addTarget(self, action: #selector(expandButtonTapped(sender:)), for: .touchUpInside)
        
        if indexPath.row == 0 {
            cell.hideButton()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "showDetails", sender: self)
        feedTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsVC,
           let index = feedTableView.indexPathForSelectedRow?.row {
            
            destination.post = posts[index]
        }
    }
}
