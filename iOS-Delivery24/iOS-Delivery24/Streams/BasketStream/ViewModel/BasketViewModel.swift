//
// BasketViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol BasketViewModelProtocol {}

final class BasketViewModel: ObservableObject {
    @Published var products: [Product]
    @Published var notifications: [NotificationInfo]

    init(products: [Product] = [], notifications: [NotificationInfo] = []) {
        self.products = products
        self.notifications = notifications
    }
}

extension BasketViewModel: BasketViewModelProtocol {
}
