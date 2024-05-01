//
//  ErrorFactory.swift
//  ItunesSearchExample
//
//  Created by Joon Baek on 2024/04/22.
//

final class ErrorFactory {
    static func makeError(fromErrorCode code: Int, errorDescription: String?) -> NetworkError {
        switch code {
        case 404:
            return .badURL
        case 500...599:
            return .badResponse(code)
        default:
            if let description = errorDescription {
                return .decoding(nil)
            } else {
                return .unknown
            }
        }
    }
}

