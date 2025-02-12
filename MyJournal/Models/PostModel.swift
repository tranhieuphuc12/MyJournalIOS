//
//  Post.swift
//  MyJournal
//
//  Created by DaiTran on 17/1/25.
//

import Foundation

struct Post: Identifiable, Hashable, Codable {
    let id: Int
    let title, content, imageUrl: String
    let createdAt, updatedAt: Date
    
}
