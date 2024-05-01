//
//  SearchModel.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/20.
//

import Foundation

struct SearchModel: resultRepresentable {
    let appIcon: URL
    let title: String
    let category: String
    let trackId: Int
}
