//
//  APIError.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
    case decodingError
    case noData
}
