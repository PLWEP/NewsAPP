//
//  NewsModel.swift
//  NewsAPP
//
//  Created by PLWEP on 27/03/23.
//

import Foundation


// MARK: - APIResult
struct APIResult: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

