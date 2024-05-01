//
//  SearchViewController.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/20.
//

import UIKit

// MARK: - SearchViewController

final class SearchViewController: BaseViewController {
    
    typealias DataTransferHandler = (Int) -> Void
    
    private var onTapCell: DataTransferHandler?
    private var searchResults: [SearchModel] = []
    
    private var rootView = SearchView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rootView.clearText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.prepareForSearch()
        rootView.setSearchBarDelegate(self)
        rootView.setTableViewDelegateAndDataSouce(delegate: self, dataSource: self)
        configureOnCell()
    }
    
    private func configureOnCell() {
        onTapCell = { [weak self] trackId in
            let detailView = DetailViewController()
            detailView.configure(with: trackId)
            self?.navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        fetchAppsForSearchTerm(text)
        rootView.hideKeyboard()
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = searchResults[indexPath.row]
        let selectedID = selectedModel.trackId
        onTapCell?(selectedID)
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = searchResults[indexPath.row]
        
        return rootView.bindCell(image: result.appIcon, title: result.title, category: result.category, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.screenHeight * 0.1
    }
}

// MARK: - Network

extension SearchViewController {
    func fetchAppsForSearchTerm(_ searchTerm: String) {
        Task {
            do {
                let appSearchResult = try await NetworkService.shared.fetchAppAPI(term: searchTerm)
                
                let models = appSearchResult.results.map { result -> SearchModel in
                    return SearchModel(appIcon: result.artworkUrl100, title: result.trackName, category: result.primaryGenreName, trackId: result.trackId)
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.searchResults = models
                    self?.rootView.reloadData()
                }
            } catch {
                print("Error fetching search results: \(error)")
            }
        }
    }
}
