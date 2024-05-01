//
//  SearchResultLoader.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/24.
//

import Foundation

final class SearchResultLoader {
    private var isLoading = false
    private var currentPage = 0
    private let itemsPerPage = 20
    var totalResults = [SearchModel]()

    func loadMoreResults(completion: @escaping ([SearchModel]) -> Void) {
        guard !isLoading else { return }

        isLoading = true
        DispatchQueue.global().async {
            // 데이터 로딩 로직
            let newResults: [SearchModel] = (1...self.itemsPerPage).map { index -> SearchModel in
                let id = index + self.itemsPerPage * self.currentPage
                
                // 임시 데이터 생성
                let appIconURL = URL(string: "https://example.com/appicon\(id).png")!
                let title = "앱 \(id)"
                let category = "카테고리 \(id % 3)"  // 예시로 3가지 유형의 카테고리를 반복합니다.
                let trackId = id
                
                return SearchModel(appIcon: appIconURL, title: title, category: category, trackId: trackId)
            }
            DispatchQueue.main.async {
                self.totalResults += newResults
                self.currentPage += 1
                self.isLoading = false
                completion(newResults)
            }
        }
    }
}

