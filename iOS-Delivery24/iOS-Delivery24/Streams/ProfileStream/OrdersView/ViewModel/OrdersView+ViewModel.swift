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
    // MARK: Actions
    func didTapReloadOrder()
    func didTapOrderInfo()
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
}

// MARK: - Actions

extension OrdersViewModel {

    func didTapReloadOrder() {}

    func didTapOrderInfo() {}

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
    }
}
