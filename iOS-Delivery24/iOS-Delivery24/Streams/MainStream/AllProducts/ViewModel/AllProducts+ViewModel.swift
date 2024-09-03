//
//  AllProducts+ViewModel.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 03.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation
import Combine

protocol AllProductsViewModelProtocol: ViewModelProtocol {
    // MARK: Networks
    // MARK: Actions
    // MARK: Reducers
    func setReducers(nav: Navigation, mainVM: MainViewModel)
    // MARK: Values
    var data: AllProductsViewModel.AllProductsVMData { get }
    var uiProperties: AllProductsViewModel.UIProperties { get set }
}

final class AllProductsViewModel: AllProductsViewModelProtocol {
    @Published private(set) var data: AllProductsVMData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()
    private var store: Set<AnyCancellable> = []

    init(
        data: AllProductsVMData = .init(),
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }
}

// MARK: - Network

extension AllProductsViewModel {
}

// MARK: - Actions

extension AllProductsViewModel {
}

// MARK: - Reducers

extension AllProductsViewModel {

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
    }
}
