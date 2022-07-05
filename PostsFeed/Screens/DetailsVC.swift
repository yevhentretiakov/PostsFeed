//
//  DetailPageVC.swift
//  PostsFeed
//
//  Created by user on 30.06.2022.
//

import UIKit

class DetailsVC: UIViewController {
    
    var postId: Int?
    
    @IBOutlet private weak var postContentView: UIView!
    
    @IBOutlet private weak var postImage: UIImageView!
    @IBOutlet private weak var postTitle: UILabel!
    @IBOutlet private weak var postBody: UILabel!
    @IBOutlet private weak var postLikes: UILabel!
    @IBOutlet private weak var postDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPost()
    }
    
    private func getPost() {
        if let postId = postId {
            NetworkManager.shared.fetch(from: .getPost(id: postId)) { (result : Result<PostDetail, ErrorMessage>) in
                switch result {
                case .success(let postData):
                    
                    let post = postData.post
                    
                    DispatchQueue.main.async {
                        self.updateContent(post: post)
                    }
                case .failure(let errorMessage):
                    print(errorMessage.rawValue)
                }
            }
        }
    }
    
    private func updateContent(post: PostFull) {
        if let url = URL(string: post.postImage) {
            let data = try? Data(contentsOf: url)
            self.postImage.image = UIImage(data: data!)
        }
        
        self.postTitle.text = post.title
        self.postBody.text = post.text
        
        self.postLikes.text = String(post.likes_count)
        self.postDate.text = post.timeshamp.toDate.extract("dd MMMM")
        
        self.postContentView.isHidden = false
    }
}
