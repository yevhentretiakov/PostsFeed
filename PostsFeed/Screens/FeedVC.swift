//
//  ViewController.swift
//  PostsFeed
//
//  Created by user on 30.06.2022.
//

import UIKit

class FeedVC: UIViewController {
    
    @IBOutlet private weak var feedTableView: UITableView!
    @IBOutlet private weak var filterButton: UIBarButtonItem!
    
    private var posts = [PostPreview]()
    
    private var menuItems: [UIAction] {
        return [
            UIAction(title: "Sort by Date", image: UIImage(systemName: "clock.arrow.circlepath")) { _ in
                self.sortPostsByDate()
                self.feedTableView.reloadData()
            },
            UIAction(title: "Sort by Likes", image: UIImage(systemName: "heart")) { _ in
                self.sortPostsByLikes()
                self.feedTableView.reloadData()
            }
        ]
    }
    
    private var demoMenu: UIMenu {
        return UIMenu(title: "Sort Options", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Feed"
        
        getFeed()
        configureFeedTableView()

        filterButton.menu = demoMenu
    }
    
    private func getFeed() {
        NetworkManager.shared.fetch(from: .getFeed) { (result : Result<Posts, ErrorMessage>) in
            switch result {
            case .success(let feed):
                self.posts = feed.posts
                self.sortPostsByDate()
                DispatchQueue.main.async {
                    self.feedTableView.reloadData()
                }

            case .failure(let errorMessage):
                print(errorMessage.rawValue)
            }
        }
    }
    
    private func configureFeedTableView() {
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        feedTableView.register(UINib.init(nibName: PostCell.reuseID, bundle: nil), forCellReuseIdentifier: PostCell.reuseID)
    }
    
    private func sortPostsByDate() {
        posts = posts.sorted(by: { $0.timeshamp.toDate > $1.timeshamp.toDate })
    }
    
    private func sortPostsByLikes() {
        posts = posts.sorted(by: { $0.likes_count > $1.likes_count })
    }
    
    @objc private func expandButtonTapped(sender: UIButton) {
        
        let tag = sender.tag
        //posts[tag].isExpanded.toggle()
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetails", sender: self)
        feedTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsVC,
           let index = feedTableView.indexPathForSelectedRow?.row {
            destination.postId = posts[index].postId
        }
    }
}

