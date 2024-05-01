//
//  DescriptionCollectionViewCell.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/23.
//

import UIKit

import SnapKit

final class DescriptionCollectionViewCell: UICollectionViewCell {
    static let identifier = "DescriptionCollectionViewCell"
    
    private lazy var dividerView = ComponentFactory.makeDividerView()
    
    private lazy var vStackView = ComponentFactory.makeStackView(axis: .vertical, views: [bodyLabel, headerLabel])
    private lazy var bodyLabel = ComponentFactory.makeBodyLabel()
    private lazy var headerLabel = ComponentFactory.makeHeaderLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        contentView.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DescriptionCollectionViewCell {
    private func configureCell() {
        contentView.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(4)
        }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    return DetailViewController()
//}
