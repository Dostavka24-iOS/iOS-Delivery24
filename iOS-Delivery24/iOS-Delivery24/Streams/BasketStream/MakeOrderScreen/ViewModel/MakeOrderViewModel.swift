//
// MakeOrderViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol MakeOrderViewModelProtocol: ViewModelProtocol {
    // MARK: Network
    func sendOrder()
    // MARK: Actions
    func didTapApplyBonuses()
    func didTapMakeOrder()
    func didTapOpenProductsList()
    func didTapProduct(product: BasketViewModel.Product)
    // MARK: Reducers
    func setReducers(nav: Navigation, mainVM: MainViewModel)
}

final class MakeOrderViewModel: MakeOrderViewModelProtocol {
    @Published var data: MakeOrderVMData
    @Published var uiProperties: UIProperies
    private var reducers = Reducers()
    private var store: Set<AnyCancellable> = []

    private let orderService = APIManager.shared.orderService

    init(
        data: MakeOrderVMData,
        uiProperties: UIProperies = .init()
    ) {
        self.uiProperties = uiProperties
        self.data = data
    }

    var bonusesIncluded: Bool {
        uiProperties.bonusesIncluded
    }

    var deliveryTitle: String {
        data.deliveryPrice == 0 ? "Бесплатно" : String(data.deliveryPrice)
    }
}

// MARK: - Actions

extension MakeOrderViewModel {

    private func findProductInfo() {
    }

    func sendOrder() {
        guard
            let token = reducers.mainVM.data.userModel?.token
        else {
            return
        }

        #warning("Тут должен быть ID адреса")
        // FIXME: Тут должен быть ID адреса
        let addOrderPublisher = orderService.makeOrderPublisher(
            body: .init(
                token: token,
                addressID: 1941,
                bonus: Int(uiProperties.bonusesCount) ?? 0,
                products: data.products.map {
                    .init(id: String($0.id), count: $0.startCount / $0.coeff)
                }
            )
        )
        uiProperties.buttonState = .loading
        addOrderPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    Logger.log(message: "Заказ создан успешно")
                    uiProperties.buttonState = .default
                    reducers.mainVM.resetBasket()
                    uiProperties.showSuccessView = true
                case .failure(let apiError):
                    Logger.log(kind: .error, message: apiError)
//                    uiProperties.buttonState = .default
                }
            } receiveValue: { _ in
            }.store(in: &store)
    }
}

// MARK: - Actions

extension MakeOrderViewModel {
    
    /// Нажали `применить` бонусы
    func didTapApplyBonuses() {
        // Число должно быть кратным 100
        guard let number = Int(uiProperties.bonusesCount), number % 100 == 0 else {
            return
        }
        data.bonusesCount = Int(uiProperties.bonusesCount)
    }
    
    /// Нажали `Оформить заказ`
    func didTapMakeOrder() {
        data.bonusesCount = bonusesIncluded ? data.bonusesCount : 0
        sendOrder()
    }

    func didTapOpenProductsList() {}

    func didTapProduct(product: BasketViewModel.Product) {}
}

// MARK: - Reducers

extension MakeOrderViewModel {

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
    }
}
