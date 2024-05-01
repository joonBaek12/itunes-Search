//
//  NetworkService.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/21.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService(provider: NetworkProvider.shared)
    
    private let provider: NetworkProvider
    
    private init(provider: NetworkProvider) {
        self.provider = provider
    }
    
    /// 앱 검색 API
    func fetchAppAPI(term: String) async throws -> AppSearchResult {
        let searchTerm = term.replacingOccurrences(of: " ", with: "+")
        let queryItems = [URLQueryItem(name: "term", value: searchTerm),
                          URLQueryItem(name: "entity", value: "software")]
        do {
            let searchResponse: AppSearchResult = try await provider.fetchAPI(path: "search", queryItems: queryItems)
            return searchResponse
        } catch {
            throw error
        }
    }
    
    /// 앱 상세 정보 API
    func fetchDetailAPI(appId: Int) async throws -> AppDetailResult {
        let queryItems = [URLQueryItem(name: "id", value: String(appId))]
        do {
            let detailResponse: AppDetailResult = try await provider.fetchAPI(path: "lookup", queryItems: queryItems)
            return detailResponse
        } catch {
            throw error
        }
    }
}
