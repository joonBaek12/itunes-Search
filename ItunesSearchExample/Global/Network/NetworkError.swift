//
//  NetworkError.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/21.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    
    case badURL
    case urlSession(URLError?)
    case badResponse(Int)
    case invalidResponse
    case decoding(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
            case .badURL:
                return "⚠️ badURL"
            case .urlSession(let error):
                return "⚠️ urlSession error [message]: \(error.debugDescription)"
            case .badResponse(let statusCode):
                return "⚠️ bad response [status code]: \(statusCode)"
            case .invalidResponse:
                return "⚠️ invalid response"
            case .decoding(let decodingError):
                return "⚠️ decoding error: \(String(describing: decodingError))"
            case .unknown:
                return "😡 unknown error"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .badURL, .unknown:
            return "문제가 발생했습니다. URL을 확인해주세요."
        case .urlSession(let urlError):
            if let error = urlError {
                switch error.code {
                case .cannotFindHost:
                    return "서버를 찾을 수 없습니다. 도메인 이름을 확인해주세요."
                case .cannotConnectToHost:
                    return "서버에 연결할 수 없습니다. 네트워크 연결을 확인해주세요."
                case .networkConnectionLost:
                    return "네트워크 연결이 끊어졌습니다. 연결 상태를 확인하고 다시 시도해주세요."
                case .notConnectedToInternet:
                    return "인터넷에 연결되어 있지 않습니다. 인터넷 연결을 확인해주세요."
                case .timedOut:
                    return "요청 시간이 초과되었습니다. 네트워크 상태를 확인하고 다시 시도해주세요."
                default:
                    return "네트워크 오류가 발생했습니다: \(error.localizedDescription)"
                }
            } else {
                return "네트워크 오류가 발생했습니다."
            }
        case .badResponse(_), .invalidResponse:
            return "서버로부터 잘못된 응답을 받았습니다. 나중에 다시 시도해주세요."
        case .decoding(let decodingError):
            if let error = decodingError {
                return "데이터를 처리하는 중에 오류가 발생했습니다: \(error.localizedDescription)"
            } else {
                return "데이터를 처리하는 중에 오류가 발생했습니다."
            }
        }
    }
}
