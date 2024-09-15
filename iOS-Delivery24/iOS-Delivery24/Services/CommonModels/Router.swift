//
// Router.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 23.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol Urlable {
    var urlPath: String { get }
}

enum Router {
    fileprivate static let baseURLString = "https://www.dostavka24.net/api"

    enum Main {}
    enum Catalog {}
    enum Cart {}
    enum Profile {}
    enum Order {}
    enum Auth {}
}

// MARK: - Main

extension Router.Main {
    private static let endpoint = "main"

    enum Product: String, Urlable {
        case actions
        case exclusives
        case news
        case hits

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }

    enum Banner: String, Urlable {
        case banners

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }

    enum Popcats: String, Urlable {
        case popcats

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }
}

// MARK: - Cart

extension Router.Cart {
    private static let endpoint = "cart"

    enum Paths: String, Urlable {
        case add

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }
}

// MARK: - Catalog

extension Router.Catalog {
    private static let endpoint = "catalog"

    enum Paths: String, Urlable {
        case categories
        case products

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }
}

// MARK: - Profile

extension Router.Profile {
    private static let endpoint = "profile"

    enum Paths: String, Urlable {
        case user = ""
        case orders
        case order
        case cart

        var urlPath: String {
            if self == .user {
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

    enum Paths: String, Urlable {
        case auth = ""

        var urlPath: String {
            if self == .auth {
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

    enum Paths: String, Urlable {
        case addresses
        case add

        var urlPath: String {
            "\(Router.baseURLString)/\(endpoint)/\(rawValue)"
        }
    }
}
