//
// BasketViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol BasketViewModelProtocol: ViewModelProtocol {
    // MARK: Actions
    func didTapOpenCatalog()
    func didTapMakeOrderButton()
    func didTapPlus(id: String, counter: Int, productPrice: Int)
    func didTapMinus(id: String, counter: Int, productPrice: Int)
    func didTapLike(id: String, isSelected: Bool)
    func didTapDelete(id: String, counter: Int, productPrice: Int)
}

final class BasketViewModel: BasketViewModelProtocol {
    @Published var data: BasketData
    @Published var uiProperties: UIProperties

    init(
        data: BasketData = .init(),
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }

    var basketIsEmpty: Bool {
        data.products.isEmpty
    }

    var products: [Product] {
        data.products
    }

    var needPrice: Int {
        let dif = data.MINIMUM_PRICE - data.resultSum
        return max(dif, 0)
    }
}

// MARK: - Actions

extension BasketViewModel {
    
    /// Функция открытия каталога, когда коризан пуста
    func didTapOpenCatalog() {
    }

    /// Функция `оформить заказ`
    func didTapMakeOrderButton() {
    }

    func didTapPlus(id: String, counter: Int, productPrice: Int) {
        let oldPrice = data.resultSum
        data.resultSum += productPrice
        print("[DEBUG]: id=\(id) counter=\(counter) oldPrice=\(oldPrice) newPrice=\(data.resultSum)")
    }

    func didTapMinus(id: String, counter: Int, productPrice: Int) {
        let oldPrice = data.resultSum
        data.resultSum -= productPrice
        print("[DEBUG]: id=\(id) counter=\(counter) oldPrice=\(oldPrice) newPrice=\(data.resultSum)")
    }

    func didTapLike(id: String, isSelected: Bool) {
        print("[DEBUG]: id=\(id) isSelected=\(isSelected)")
    }

    func didTapDelete(id: String, counter: Int, productPrice: Int) {
        let oldPrice = data.resultSum
        data.resultSum -= productPrice * counter
        print("[DEBUG]: deleted by id: \(id) | oldPrice=\(oldPrice) newPrice=\(data.resultSum)")
        guard let index = data.products.firstIndex(where: { $0.id == id }) else {
            return
        }
        data.products.remove(at: index)
    }
}
