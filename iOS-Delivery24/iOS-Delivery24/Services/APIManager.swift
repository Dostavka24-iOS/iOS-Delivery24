//
// APIManager.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 20.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

final class APIManager {
    static let shared = APIManager()

    let productService = ProductService.shared
    let bannerService = BannersService.shared
    let popcatsService = PopcatsService.shared
    let categoryService = CategoryService.shared
    let userService = UserService.shared
    let authService = AuthService.shared

    private init() {}
}
