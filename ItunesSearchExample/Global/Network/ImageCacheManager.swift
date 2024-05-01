//
//  ImageCacheManager.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/24.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}

extension UIImageView {
    func load(from url: String) {
        let cacheKey = NSString(string: url)
        
        // 캐시에서 이미지를 확인하고, 있다면 바로 설정
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        guard let imageURL = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else { return }
            
            DispatchQueue.main.async {
                // 다운로드된 이미지를 캐시에 저장 후 UI를 업데이트
                ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                self?.image = image
            }
        }
        task.resume()
    }
}
