//
//  ComponentFactory.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/21.
//

import UIKit

struct ComponentFactory {
    static func makeStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 10, alignment: UIStackView.Alignment = .center, distribution: UIStackView.Distribution = .equalSpacing, views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        return stackView
    }
    
    static func makeImageView(cornerRadius: CGFloat = 20) -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        
        return imageView
    }
    
    static func makeDownLoadButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("GET", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.layer.cornerRadius = 12
        
        return button
    }
    
    static func makeDividerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        return view
    }
}

extension ComponentFactory: LabelConfigurable {
    static func makeHeaderLabel(text: String = "makeHeaderLabel") -> UILabel {
        return configureLabel(font: UIFont.systemFont(ofSize: 24, weight: .bold), textColor: .black, text: text)
    }
    
    static func makeTitleLabel(text: String = "makeBodyLabel") -> UILabel {
        return configureLabel(font: UIFont.systemFont(ofSize: 16, weight: .medium), textColor: .black, numberOfLines: 1, text: text)
    }
    
    static func makeBodyLabel(text: String = "makeBodyLabel") -> UILabel {
        return configureLabel(font: UIFont.systemFont(ofSize: 16), textColor: .black, text: text)
    }
    
    static func makeGrayBodyLabel(text: String = "makeBodyLabel") -> UILabel {
        return configureLabel(font: UIFont.systemFont(ofSize: 16), textColor: .darkGray, text: text)
    }
}
