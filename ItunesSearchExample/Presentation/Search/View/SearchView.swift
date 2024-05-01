//
//  SearchView.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/20.
//

import UIKit

import SnapKit

// MARK: - SearchView

final class SearchView: BaseView {
    
    private lazy var searchBar: UISearchBar = makeSearchBar()
    private lazy var resultTableView: UITableView = makeResultTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Extensions

extension SearchView {
    
    // MARK: - FactoryMethods
    
    private func makeSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색"
        searchBar.tintColor = .systemPink
        
        return searchBar
    }
    
    private func makeResultTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.identifier)
        
        return tableView
    }
    
    // MARK: - Setup Methods
    
    private func setLayout() {
        addSubviews([searchBar, resultTableView])
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(LayoutLiterals.horizontalGap)
            make.height.equalTo(66)
        }
        
        resultTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(LayoutLiterals.verticalGap)
            make.leading.trailing.equalToSuperview().inset(LayoutLiterals.horizontalGap)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Internal Extensions

extension SearchView {
    func prepareForSearch() {
        searchBar.becomeFirstResponder()
    }
    
    func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func clearText() {
        searchBar.text = ""
    }
    
    func setSearchBarDelegate(_ delegate: UISearchBarDelegate) {
        searchBar.delegate = delegate
    }
    
    func setTableViewDelegateAndDataSouce(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        resultTableView.delegate = delegate
        resultTableView.dataSource = dataSource
    }
    
    func bindCell(image: URL , title: String, category: String, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultTableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath)
                as? ResultTableViewCell else { return UITableViewCell() }
        
        cell.setData(image: image, title: title, category: category)
        
        return cell
    }
    
    func reloadData() {
        resultTableView.reloadData()
    }
}
