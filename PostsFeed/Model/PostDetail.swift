//
//  PostDetail.swift
//  PostsFeed
//
//  Created by user on 04.07.2022.
//

import Foundation

struct PostDetail: Decodable {
    let post: PostFull
}

struct PostFull: Decodable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let text: String
    let postImage: String
    let likes_count: Int
}
