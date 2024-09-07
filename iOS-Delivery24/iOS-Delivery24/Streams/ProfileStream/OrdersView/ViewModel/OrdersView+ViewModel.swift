//
//  OrdersView+ViewModel.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation
import Combine

protocol OrdersViewModelProtocol: ViewModelProtocol {
    // MARK: Networks
    func fetchOrders()
    func fetchOrderInfo(orderID: Int)
    // MARK: Actions
    func didTapReloadOrder()
    func didTapOrderInfo(orderID: Int)
    func didTapPlus(id: Int, counter: Int, productPrice: Double)
    func didTapMinus(id: Int, counter: Int, productPrice: Double)
    func didTapLike(id: Int, isSelected: Bool)
    func didTapDelete(id: Int, counter: Int, productPrice: Double)
    func didTapProduct(id: Int)
    // MARK: Reducers
    func setReducers(nav: Navigation, mainVM: MainViewModel)
    // MARK: Values
    var data: OrdersViewModel.OrdersViewVMData { get }
    var uiProperties: OrdersViewModel.UIProperties { get set }
}

final class OrdersViewModel: OrdersViewModelProtocol {
    @Published private(set) var data: OrdersViewVMData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()
    private var store: Set<AnyCancellable> = []

    private let userService = APIManager.shared.userService

    init(
        data: OrdersViewVMData = .init(),
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }
}

// MARK: - Network

extension OrdersViewModel {

    func fetchOrders() {
        guard data.orders.isEmpty else {
            Logger.log(kind: .debug, message: "Данные заказов уже были получены ранее")
            return
        }
        guard let token = reducers.mainVM.data.userModel?.token else {
            Logger.log(kind: .error, message: "Не найден токен пользователя")
            return
        }
        uiProperties.screenState = .loading
        let orderPublisher = userService.getOrdersPublisher(token: token)
        orderPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    Logger.log(message: "Данные заказов получены успешно")
                    uiProperties.screenState = .default
                case .failure(let apiError):
                    Logger.log(kind: .error, message: apiError)
                    uiProperties.screenState = .error(apiError)
                }
            } receiveValue: { [weak self] orders in
                self?.data.orders = orders
            }.store(in: &store)
    }

    func fetchOrderInfo(orderID: Int) {
        guard let token = reducers.mainVM.data.userModel?.token else {
            Logger.log(kind: .error, message: "Не найден токен пользователя")
            return
        }

        let orderPublisher = userService.getOrdersPublisher(token: token, orderID: orderID)
        orderPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    Logger.log(message: "Данные заказа получены")
                case .failure(let apiError):
                    Logger.log(kind: .error, message: apiError)
                    // TODO: Кидать уведомление
                }
            } receiveValue: { [weak self] order in
                self?.reducers.nav.addScreen(screen: order)
            }.store(in: &store)
    }
}

// MARK: - Actions

extension OrdersViewModel {

    func didTapReloadOrder() {}

    func didTapOrderInfo(orderID: Int) {
        fetchOrderInfo(orderID: orderID)
    }

    func didTapPlus(id: Int, counter: Int, productPrice: Double) {}

    func didTapMinus(id: Int, counter: Int, productPrice: Double) {}

    func didTapLike(id: Int, isSelected: Bool) {}

    func didTapDelete(id: Int, counter: Int, productPrice: Double) {}

    func didTapProduct(id: Int) {}
}

// MARK: - Reducers

extension OrdersViewModel {

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
        data.moneyCount = mainVM.data.userModel?.balance ?? "0"
    }
}
