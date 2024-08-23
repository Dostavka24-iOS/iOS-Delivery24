//
// Router.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 23.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

enum Router {
    static let baseURLString = "https://www.dostavka24.net/api/main"
}

extension Router {

    enum Product {
        static let actions = "\(baseURLString)/actions"
        static let exclusives = "\(baseURLString)/exclusives"
        static let news = "\(baseURLString)/news"
        static let hits = "\(baseURLString)/hits"
    }
}
