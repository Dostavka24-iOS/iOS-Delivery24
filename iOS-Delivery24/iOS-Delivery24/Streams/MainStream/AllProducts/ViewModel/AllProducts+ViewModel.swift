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
    func didTapProductCard(for product: CategoryProductEntity)
    func didTapProductCard(for product: ProductEntity)
    func didTapProductLike(productID: Int, isLike: Bool)
    func didTapProductPlus(productID: Int, counter: Int)
    func didTapProductMinus(productID: Int, counter: Int)
    func didTapProductBasket(productID: Int, counter: Int)
    // MARK: Reducers
    func setReducers(nav: Navigation, mainVM: MainViewModel)
    // MARK: Values
    var data: AllProductsViewModel.AllProductsVMData { get }
    var uiProperties: AllProductsViewModel.UIProperties { get set }
    var moneyCount: String? { get }
}

final class AllProductsViewModel: AllProductsViewModelProtocol {
    @Published private(set) var data: AllProductsVMData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()
    private var store: Set<AnyCancellable> = []

    init(
        data: AllProductsVMData,
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }

    var moneyCount: String? {
        guard reducers.mainVM != nil else { return nil }
        return reducers.mainVM.data.userModel?.balance
    }
}

// MARK: - Network

extension AllProductsViewModel {
}

// MARK: - Actions

extension AllProductsViewModel {

    func didTapProductLike(productID: Int, isLike: Bool) {}
    func didTapProductPlus(productID: Int, counter: Int) {}
    func didTapProductMinus(productID: Int, counter: Int) {}
    func didTapProductBasket(productID: Int, counter: Int) {}
    func didTapProductCard(for product: ProductEntity) {}
    func didTapProductCard(for product: CategoryProductEntity) {}
}

// MARK: - Reducers

extension AllProductsViewModel {

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
    }
}
