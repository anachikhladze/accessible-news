//
//  NewsModel.swift
//  AccessibleNews
//
//  Created by Anna Sumire on 27.12.23.
//

import Foundation

// MARK: - Article
struct Article: Decodable {
    let articles: [News]
}

// MARK: - News
struct News: Decodable {
    let author: String?
    let title: String
    let urlToImage: String?
}
