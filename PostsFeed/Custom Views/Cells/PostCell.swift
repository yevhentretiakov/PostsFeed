//
//  PostCell.swift
//  PostsFeed
//
//  Created by user on 30.06.2022.
//

import UIKit

class PostCell: UITableViewCell {
    
    static let reuseID = "PostCell"
    
    @IBOutlet private weak var postTitle: UILabel!
    @IBOutlet weak var postBody: UILabel!
    @IBOutlet private weak var postLikes: UILabel!
    @IBOutlet private weak var postDate: UILabel!
    
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet private weak var expandButtonBottomAnchor: NSLayoutConstraint!
    @IBOutlet private weak var expandButtonHeightAnchor: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        //print("cell \(postBody.frame.height)")


    }
    
    func set(post: PostPreview) {
        postTitle.text = post.title
        postBody.text = post.preview_text
        postLikes.text = String(post.likes_count)
        postDate.text = post.timeshamp.toDate.extract("dd MMMM")
        
        if let expanded = post.isExpanded, expanded {
            postBody.numberOfLines = 0
            expandButton.setTitle(ExpandButton.collapse.rawValue, for: .normal)
        } else {
            postBody.numberOfLines = 2
            expandButton.setTitle(ExpandButton.expand.rawValue, for: .normal)
        }
    }
    
    @IBAction private func toggleTapped(_ sender: UIButton) {
        
    }
    
    func hideButton() {
        expandButton.isHidden = true
        expandButtonBottomAnchor.constant = 0
        expandButtonHeightAnchor.constant = 0
    }
}
