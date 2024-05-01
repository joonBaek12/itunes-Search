//
//  BaseView.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/20.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("✅ \(self) is being deinitialized")
    }
    
    func setBackgroundColor() {
        backgroundColor = .white
    }
}
