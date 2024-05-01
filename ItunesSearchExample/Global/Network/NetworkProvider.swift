//
//  NetworkManager.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/21.
//

import Foundation

final class NetworkProvider {
    
    static let shared = NetworkProvider()
    
    private init() { }
    
    private let baseURL = URL(string: "https://itunes.apple.com/")
    
    func fetchAPI<T: Decodable>(path: String, queryItems: [URLQueryItem]) async throws -> T {
        guard let baseURL = baseURL else {
            throw ErrorFactory.makeError(fromErrorCode: 404, errorDescription: "Invalid base URL")
        }
        
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw ErrorFactory.makeError(fromErrorCode: 404, errorDescription: "Invalid URL")
        }
        
        let request = URLRequest(url: url)
        NetworkLogger.log(request: request)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            NetworkLogger.log(response: response, data: data, error: nil)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ErrorFactory.makeError(fromErrorCode: 500, errorDescription: "Invalid response type")
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                throw ErrorFactory.makeError(fromErrorCode: httpResponse.statusCode, errorDescription: nil)
            }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            NetworkLogger.log(response: nil, data: nil, error: error)
            if let decodingError = error as? DecodingError {
                throw ErrorFactory.makeError(fromErrorCode: -1, errorDescription: decodingError.localizedDescription)
            }
            throw error
        }
    }
}

