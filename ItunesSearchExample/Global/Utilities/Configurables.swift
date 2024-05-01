//
//  Configurables.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/21.
//

import UIKit

protocol LabelConfigurable {}

extension LabelConfigurable {
    static func configureLabel(font: UIFont = UIFont.systemFont(ofSize: 16), textColor: UIColor = .black, numberOfLines: Int = 1, text: String) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.text = text
        label.lineBreakMode = .byTruncatingTail
        return label
    }
}

