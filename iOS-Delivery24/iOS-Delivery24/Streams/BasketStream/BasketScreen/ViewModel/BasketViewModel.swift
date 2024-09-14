//
// BasketViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

protocol BasketViewModelProtocol: ViewModelProtocol {
    // MARK: Network
    func fetchBasketProducts()
    // MARK: Lifecycle
    func onAppear()
    // MARK: Actions
    func didTapProduct(id: Int)
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
    @Published private(set) var data: BasketData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()

    private var store: Set<AnyCancellable> = []
    private let profileService = APIManager.shared.userService

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

    var showLoaderView: Bool {
        [ScreenState.initial, .loading].contains(
            uiProperties.screenState
        )
    }
}

// MARK: - Network

extension BasketViewModel {

    func fetchBasketProducts() {
        uiProperties.screenState = .loading

        guard
            let token = reducers.mainVM.data.userModel?.token,
            let addressID = reducers.mainVM.data.userAddressID
        else {
            Logger.log(kind: .error, message: "Не найден токен или адрес пользователя")
            return
        }
        profileService.getProductBasket(
            token: token,
            addressID: addressID
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            guard let self else { return }
            switch completion {
            case .finished:
                Logger.log(message: "Данные корзины получены успешно!")
                withAnimation {
                    self.uiProperties.screenState = .default
                }
            case let .failure(apiError):
                Logger.log(kind: .error, message: apiError)
                uiProperties.screenState = .error(apiError)
            }
        } receiveValue: { [weak self] products in
            self?.updateProducts(with: products)
        }.store(in: &store)
    }
}

// MARK: - Actions

extension BasketViewModel {

    /// Функция открытия каталога, когда коризан пуста
    func didTapOpenCatalog() {
        reducers.mainVM.uiProperties.tabItem = .catalog
    }

    /// Нажали карточку товара
    func didTapProduct(id: Int) {
        guard let product = reducers.mainVM.getProductByID(for: id) else {
            // TODO: Кинуть уведомление об ошибке
            return
        }
        reducers.nav.addScreen(screen: Screens.product(product))
    }

    /// Функция `оформить заказ`
    func didTapMakeOrderButton() {
        reducers.nav.addScreen(screen: Screens.makeOrder)
    }

    func didTapPlus(id: Int, counter: Int, productPrice: Double) {
        guard let index = data.products.firstIndex(where: { $0.id == id }) else {
            return
        }
        let product = data.products[index]
        let resultProductPrice = product.unitPrice * Double(counter)
        data.resultSum += resultProductPrice - productPrice
        data.products[index].price = resultProductPrice
        data.products[index].startCount = counter
        reducers.mainVM.didUpdateBasketProduct(id: id, newCounter: counter, coeff: product.coeff)
    }

    func didTapMinus(id: Int, counter: Int, productPrice: Double) {
        guard let index = data.products.firstIndex(where: { $0.id == id }) else {
            return
        }
        let product = data.products[index]
        let resultProductPrice = product.unitPrice * Double(counter)
        data.resultSum -= productPrice - resultProductPrice
        data.products[index].price = resultProductPrice
        data.products[index].startCount = counter
        reducers.mainVM.didUpdateBasketProduct(id: id, newCounter: counter, coeff: product.coeff)
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
//        var resultSum = 0.0
//        data.products = reducers.mainVM.data.basketProducts.compactMap { id, counterInfo in
//            guard
//                var product = reducers.mainVM.getProductByID(for: id)?.mapperToBasketProduct
//            else {
//                return nil
//            }
//            let (counter, _) = counterInfo
//            product.startCount = counter
//            product.price = Double(counter) * product.unitPrice
//            resultSum += product.price
//            return product
//        }
//        data.resultSum = resultSum

        // Запрос в сеть
        fetchBasketProducts()
    }

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
    }
}

// MARK: - Helper

private extension BasketViewModel {

    func updateProducts(with networkProducts: [ProductEntity]) {
        var resultSum = 0.0
        data.products = networkProducts.compactMap { product in
            resultSum += (Double(product.price ?? "") ?? 0)
            return product.mapperToBasketProduct
        }
        data.resultSum = resultSum

//        networkProducts.forEach { product in
//            let productPrice = Double(product.price ?? "") ?? 0
//            resultSum += productPrice
//            guard
//                let index = data.products.firstIndex(where: { $0.id == product.id })
//            else {
//                if let productModel = product.mapperToBasketProduct {
//                    data.products.append(productModel)
//                }
//                return
//            }
//            guard let productModel = product.mapperToBasketProduct else {
//                Logger.log(kind: .error, message: "Ошибка маппинга ProductEntity в Product")
//                return
//            }
//            data.products[index] = productModel
//        }
//        data.resultSum = resultSum
    }
}
