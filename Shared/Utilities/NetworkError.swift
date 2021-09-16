//
//  APIError.swift
//  Wethery
//
//  Created by Ethan Zemelman on 2021-09-11.
//

import Foundation

enum NetworkError: Error {
    case invalidData
    case invalidURL
    case invalidResponse
}
