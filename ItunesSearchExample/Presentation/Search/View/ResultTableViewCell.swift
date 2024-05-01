//
//  ResultTableViewCell.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/23.
//

import UIKit

import SnapKit

// MARK: - ResultTableViewCell

final class ResultTableViewCell: UITableViewCell {
    static let identifier = "ResultTableViewCell"
    
    private let appIconView = ComponentFactory.makeImageView()
    private let titleLabel = ComponentFactory.makeTitleLabel()
    private let categoryLabel = ComponentFactory.makeGrayBodyLabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

// MARK: - Private Extension

extension ResultTableViewCell {
    private func configureCell() {
        addSubviews([appIconView, titleLabel, categoryLabel])
        
        appIconView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(4)
            make.width.equalTo(self.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconView).offset(8)
            make.leading.equalTo(appIconView.snp.trailing).offset(8)
            make.width.equalTo(UIScreen.screenWidth * 0.6)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
        }
    }
}

// MARK: - Internal Extension

extension ResultTableViewCell {
    func setData(image: URL, title: String, category: String) {
        appIconView.load(from: image.absoluteString)
        titleLabel.text = title
        categoryLabel.text = category
    }
}
