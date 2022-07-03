//
//  DetailPageVC.swift
//  PostsFeed
//
//  Created by user on 30.06.2022.
//

import UIKit

class DetailsVC: UIViewController {

    var post: Post?
    
    @IBOutlet private weak var postImage: UIImageView!
    @IBOutlet private weak var postTitle: UILabel!
    @IBOutlet private weak var postBody: UILabel!
    @IBOutlet private weak var postLikes: UILabel!
    @IBOutlet private weak var postDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTitle.text = post?.title
        postBody.text = post?.body
        postLikes.text = post?.likes
        postDate.text = post?.date
    }
}
