//
//  DetailModel.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/20.
//

import Foundation

struct DetailModel: resultRepresentable {
    let appIcon: URL
    let title: String
    let description: String
    let company: String
    let mockupImage: [URL]?
}
