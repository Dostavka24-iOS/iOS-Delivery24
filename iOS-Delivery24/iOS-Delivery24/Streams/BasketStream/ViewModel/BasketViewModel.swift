//
// BasketViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol BasketViewModelProtocol {
    func didTapOpenCatalog()
}

final class BasketViewModel: ObservableObject {
    @Published var products: [Product]
    @Published var notifications: [NotificationInfo]
    @Published var uiProperties: UIProperties

    init(
        products: [Product] = [],
        notifications: [NotificationInfo] = [],
        uiProperties: UIProperties = .init()
    ) {
        self.products = products
        self.notifications = notifications
        self.uiProperties = uiProperties
    }

    var basketIsEmpty: Bool {
        products.isEmpty
    }
}

extension BasketViewModel: BasketViewModelProtocol {
    
    /// Функция откртия каталога, когда коризан пуста
    func didTapOpenCatalog() {
    }
}
