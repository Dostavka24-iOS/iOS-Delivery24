//
//  OrdersView+ViewModel.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation
import Combine

protocol OrdersViewViewModelProtocol: ViewModelProtocol {
    // MARK: Networks
    // MARK: Actions
    // MARK: Reducers
    func setReducers(nav: Navigation, mainVM: MainViewModel)
    // MARK: Values
    var data: OrdersViewViewModel.OrdersViewVMData { get }
    var uiProperties: OrdersViewViewModel.UIProperties { get set }
}

final class OrdersViewViewModel: OrdersViewViewModelProtocol {
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

extension OrdersViewViewModel {
}

// MARK: - Actions

extension OrdersViewViewModel {
}

// MARK: - Reducers

extension OrdersViewViewModel {

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
    }
}
