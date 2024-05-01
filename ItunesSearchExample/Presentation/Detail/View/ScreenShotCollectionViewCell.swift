//
//  ScreenShotCollectionViewCell.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/23.
//

import UIKit

import SnapKit

final class ScreenShotCollectionViewCell: UICollectionViewCell {
    static let identifier = "ScreenShotCollectionViewCell"
    
    private lazy var imageView: UIImageView = ComponentFactory.makeImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScreenShotCollectionViewCell {
    private func configureCell() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ScreenShotCollectionViewCell {
    func setData(imageURL: URL) {
        imageView.load(from: imageURL.absoluteString)
    }
}
