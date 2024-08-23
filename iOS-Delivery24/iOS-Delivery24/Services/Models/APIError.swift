//
// APIError.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 23.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError(Error)
    case error(Error)
}
