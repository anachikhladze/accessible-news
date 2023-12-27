//
//  NetworkManager.swift
//  AccessibleNews
//
//  Created by Anna Sumire on 27.12.23.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchNewsData() async throws -> Article {
        let endpoint = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=8573d1e70d304f21b67676f56b9a4fa3"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Article.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
