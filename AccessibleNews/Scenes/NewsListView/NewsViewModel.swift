//
//  NewsViewModel.swift
//  AccessibleNews
//
//  Created by Anna Sumire on 27.12.23.
//

import Foundation

final class NewsViewModel: ObservableObject {
    @Published var newsTitles: [String] = []
    
    init() {
        fetchNews()
    }
    
    func fetchNews() {
        Task {
            do {
                let fetchedNewsData = try await NetworkManager.shared.fetchNewsData()
                DispatchQueue.main.async {
                    self.newsTitles = fetchedNewsData.articles.map { $0.title }
                }
            } catch {
                print("Error fetching products: \(error.localizedDescription)")
            }
        }
    }
}
