//
//  DetailViewController.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/20.
//

import UIKit

// MARK: - DetailViewController

final class DetailViewController: BaseViewController {
    
    private var detailResults: [DetailModel] = []
    private var trackId: Int?
    
    private var rootView = DetailView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.setCollectionView(delegate: self, dataSource: self)
    }
}

// MARK: - Internal Extension

extension DetailViewController {
    func configure(with id: Int) {
        trackId = id
        fetchAppsForSearchTerm(trackId ?? 0)
    }
}

// MARK: - UICollectionViewDataSource

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        let totalMockupImageCount = detailResults.compactMap { $0.mockupImage }.flatMap { $0 } .count
        
        return rootView.numberOfItems(in: section, with: totalMockupImageCount , collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let totalMockupImages = detailResults.compactMap { $0.mockupImage }.flatMap { $0 }
        
        return rootView.bindCell(at: indexPath, collectionView, imageURL: totalMockupImages)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        rootView.sizeForItem(at: indexPath, collectionView)
    }
}

// MARK: - Network

extension DetailViewController {
    func fetchAppsForSearchTerm(_ appId: Int) {
        Task {
            do {
                let appSearchResult = try await NetworkService.shared.fetchDetailAPI(appId: appId)
                let models = appSearchResult.results.map { result -> DetailModel in
                    return DetailModel(appIcon: result.artworkUrl100,
                                       title: result.trackName,
                                       description: result.description,
                                       company: result.sellerName,
                                       mockupImage: result.screenshotUrls)
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.detailResults = models
                    if let firstResult = self?.detailResults.first {
                        self?.rootView.updateHeaderView(with: firstResult.appIcon,
                                                        firstResult.title,
                                                        firstResult.company)
                        self?.rootView.reloadData()
                    }
                }
            } catch {
                print("Error fetching search results: \(error)")
            }
        }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    return DetailViewController()
//}

