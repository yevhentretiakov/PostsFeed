//
//  Post.swift
//  PostsFeed
//
//  Created by user on 30.06.2022.
//

import Foundation

struct Posts: Decodable {
    let posts: [PostPreview]
}

struct PostPreview: Decodable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let preview_text: String
    let likes_count: Int
    var isExpanded: Bool? = false
}
