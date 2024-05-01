//
//  NetworkModels.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/21.
//

import Foundation

struct AppSearchResult: Codable {
    let results: [AppInfo]
}

struct AppInfo: Codable {
    let trackName: String // 앱 타이틀
    let primaryGenreName: String // 카테고리
    let averageUserRating: Float? // 점수
    let artworkUrl100: URL // 앱 아이콘 URL
    let trackId: Int
    
    enum CodingKeys: String, CodingKey {
        case trackName
        case primaryGenreName
        case averageUserRating
        case artworkUrl100
        case trackId
    }
}

struct AppDetailResult: Codable {
    let resultCount: Int
    let results: [AppDetail]
}

struct AppDetail: Codable {
    let averageUserRatingForCurrentVersion: Float? // 현재 버전에 대한 사용자 평점
    let artworkUrl100: URL // 앱 아이콘 URL
    let trackContentRating: String // 연령
    let trackName: String // 앱 타이틀
    let genreIds: [String] // 세부 카테고리 ID
    let sellerName: String // 개발 회사
    let screenshotUrls: [URL] // 목업 이미지 URL 배열
    let description: String // 설명
    
    enum CodingKeys: String, CodingKey {
        case averageUserRatingForCurrentVersion
        case artworkUrl100
        case trackContentRating
        case trackName
        case genreIds
        case sellerName
        case screenshotUrls
        case description
    }
}
