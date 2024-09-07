//
// Router.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 23.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

enum Router {
    fileprivate static let baseURLString = "https://www.dostavka24.net/api"

    enum Main {}
    enum Catalog {}
    enum Profile {}
    enum Order {}
    enum Auth {}
}

// MARK: - Main

extension Router.Main {
    private static let endpoint = "main"

    enum Product: String {
        case actions = "actions"
        case exclusives = "exclusives"
        case news = "news"
        case hits = "hits"

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }

    enum Banner: String {
        case banners = "banners"

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }

    enum Popcats: String {
        case popcats = "popcats"

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }
}

// MARK: - Catalog

extension Router.Catalog {
    private static let endpoint = "catalog"

    enum Paths: String {
        case categories = "categories"
        case products = "products"

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }
}

// MARK: - Profile

extension Router.Profile {
    private static let endpoint = "profile"

    enum Paths: String {
        case user = ""
        case orders = "orders"

        var urlPath: String {
            if rawValue.isEmpty {
                "\(Router.baseURLString)/\(endpoint)"
            } else {
                "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
            }
        }
    }
}

// MARK: - Auth

extension Router.Auth {
    private static let endpoint = "auth"

    enum Paths: String {
        case auth = ""

        var urlPath: String {
            if rawValue.isEmpty {
                "\(Router.baseURLString)/\(endpoint)"
            } else {
                "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
            }
        }
    }
}

// MARK: - Order

extension Router.Order {
    private static let endpoint = "order"

    enum Paths: String {
        case addresses = "addresses"
        case add = "add"

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }
}
