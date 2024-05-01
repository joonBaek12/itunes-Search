//
//  UIView+Extension.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/21.
//

import UIKit

extension UIView {
    func addSubviews(_ views : [UIView]) {
        _ = views.map { self.addSubview($0) }
    }
}
