//
//  DetailView.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/20.
//

import UIKit

import SnapKit

// MARK: - DetailView

final class DetailView: BaseView {
    
    // MARK: - Properties
    
    private lazy var scrollView: UIScrollView = makeScrollView()
    private lazy var contentView: UIView = UIView()
    
    private lazy var headerView: UIView = makeHeaderView()
    private lazy var appImageView: UIImageView = ComponentFactory.makeImageView()
    private lazy var titleLabel: UILabel = ComponentFactory.makeHeaderLabel()
    private lazy var bodyLabel: UILabel = ComponentFactory.makeBodyLabel()
    //    private lazy var downLoadButton: UIButton = ComponentFactory.makeDownLoadButton()
    
    private lazy var descriptionCollectionView: UICollectionView = makeCollectionView(with: DescriptionCollectionViewCell.self, tag: 1)
    private lazy var ScreenShotCollectionView: UICollectionView = makeCollectionView(with: ScreenShotCollectionViewCell.self, tag: 2)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Extension

extension DetailView {
    
    // MARK: - Factory Methods
    
    private func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }
    
    private func makeHeaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }
    
    private func makeCollectionView<Cell: UICollectionViewCell>(with cellType: Cell.Type, tag: Int) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
        collectionView.tag = tag
        
        return collectionView
    }
    
    // MARK: - Setup Methods
    
    private func setLayout() {
        setupScrollView()
        setupHeaderView()
        setupCollectionView()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalTo(scrollView)
        }
    }
    
    private func setupHeaderView() {
        
        contentView.addSubview(headerView)
        headerView.addSubviews([appImageView, titleLabel, bodyLabel])
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.screenHeight * 0.14)
        }
        
        appImageView.snp.makeConstraints { make in
            make.top.leading.height.equalToSuperview()
            make.width.equalTo(headerView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(appImageView.snp.trailing).offset(15)
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel)
        }
    }
    
    private func setupCollectionView() {
        contentView.addSubviews([descriptionCollectionView, ScreenShotCollectionView])
        
        descriptionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.screenHeight * 0.1)
        }
        
        ScreenShotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(descriptionCollectionView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(UIScreen.screenHeight * 0.5)
        }
    }
}

// MARK: - Internal Extension

extension DetailView {
    func setCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        descriptionCollectionView.delegate = delegate
        ScreenShotCollectionView.delegate = delegate
        descriptionCollectionView.dataSource = dataSource
        ScreenShotCollectionView.dataSource = dataSource
    }
    
    func numberOfItems(in Section: Int, with pages: Int, _ collectionView: UICollectionView) -> Int {
        switch collectionView.tag {
        case 1:
            return 5
        case 2:
            return pages
        default:
            return 0
        }
    }
    
    func bindCell(at indexPath: IndexPath, _ collectionView: UICollectionView, imageURL: [URL]?) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            guard let cell = descriptionCollectionView.dequeueReusableCell(withReuseIdentifier: DescriptionCollectionViewCell.identifier,
                                                                           for: indexPath) as? DescriptionCollectionViewCell 
            else { return UICollectionViewCell() }
            return cell
        case 2:
            guard let cell = ScreenShotCollectionView.dequeueReusableCell(withReuseIdentifier: ScreenShotCollectionViewCell.identifier,
                                                                          for: indexPath) as? ScreenShotCollectionViewCell,
                  let url = imageURL?[indexPath.item]
            else { return UICollectionViewCell() }
            
            cell.setData(imageURL: url)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func sizeForItem(at indexPath: IndexPath, _ collectionView: UICollectionView) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenHeight * 0.6)
        case 2:
            return CGSize(width: UIScreen.screenWidth * 0.6, height: UIScreen.screenHeight * 0.5)
        default:
            return CGSize()
        }
    }
    
    func reloadData() {
        ScreenShotCollectionView.reloadData()
    }
    
    func updateHeaderView(with url: URL, _ title: String, _ company: String) {
        appImageView.load(from: url.absoluteString)
        titleLabel.text = title
        bodyLabel.text = company
    }
}
