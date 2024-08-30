//
// BasketViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol BasketViewModelProtocol: ViewModelProtocol {
    // MARK: Lifecycle
    func onAppear()
    // MARK: Actions
    func didTapOpenCatalog()
    func didTapMakeOrderButton()
    func didTapPlus(id: Int, counter: Int, productPrice: Double)
    func didTapMinus(id: Int, counter: Int, productPrice: Double)
    func didTapLike(id: Int, isSelected: Bool)
    func didTapDelete(id: Int, counter: Int, productPrice: Double)
    // MARK: Reducers
    func setReducers(nav: Navigation, mainVM: MainViewModel)
}

final class BasketViewModel: BasketViewModelProtocol {
    @Published var data: BasketData
    @Published var uiProperties: UIProperties
    @Published private var reducers = Reducers()
    private var store: Set<AnyCancellable> = []

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

    var needPrice: Double {
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

    func didTapPlus(id: Int, counter: Int, productPrice: Double) {
        guard let index = data.products.firstIndex(where: { $0.id == id }) else {
            return
        }
        let resultProductPrice = data.products[index].unitPrice * Double(counter)
        data.resultSum += resultProductPrice - productPrice
        data.products[index].price = resultProductPrice
        reducers.mainVM.didUpdateBasketProduct(id: id, newCounter: counter)
    }

    func didTapMinus(id: Int, counter: Int, productPrice: Double) {
        guard let index = data.products.firstIndex(where: { $0.id == id }) else {
            return
        }
        let resultProductPrice = data.products[index].unitPrice * Double(counter)
        data.resultSum -= productPrice - resultProductPrice
        data.products[index].price = resultProductPrice
        reducers.mainVM.didUpdateBasketProduct(id: id, newCounter: counter)
    }

    func didTapLike(id: Int, isSelected: Bool) {
        print("[DEBUG]: id=\(id) isSelected=\(isSelected)")
    }

    func didTapDelete(id: Int, counter: Int, productPrice: Double) {
        guard let index = data.products.firstIndex(where: { $0.id == id }) else {
            return
        }
        let product = data.products[index]
        data.resultSum -= product.price
        data.products.remove(at: index)
        reducers.mainVM.didDeleteBasketProduct(id: id)
    }
}

// MARK: - Reducers & Lifecycle

extension BasketViewModel {

    func onAppear() {
        var resultSum = 0.0
        data.products = reducers.mainVM.data.basketProducts.compactMap { id, counter in
            guard 
                var product = reducers.mainVM.getProductByID(for: id)?.mapperToBasketProduct
            else {
                return nil
            }
            product.startCount = counter
            product.price = Double(counter) * product.unitPrice
            resultSum += product.price
            return product
        }
        data.resultSum = resultSum
        Logger.log(message: data.products)
    }

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
    }
}
