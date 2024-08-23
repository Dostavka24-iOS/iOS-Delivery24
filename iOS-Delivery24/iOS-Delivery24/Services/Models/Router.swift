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

    enum Product: String {
        case actions = "actions"
        case exclusives = "exclusives"
        case news = "news"
        case hits = "hits"

        var urlPath: String {
            "\(baseURLString)/\(rawValue)"
        }
    }

    enum Banner: String {
        case banners = "banners"

        var urlPath: String {
            "\(baseURLString)/\(rawValue)"
        }
    }

    enum Popcats: String {
        case popcats = "popcats"

        var urlPath: String {
            "\(baseURLString)/\(rawValue)"
        }
    }
}
