//
// CatalogProductsViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 01.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol CatalogProductsViewModelProtocol: ViewModelProtocol {
    // MARK: Reducers
    func setReducers(nav: Navigation)
    // MARK: Actions
    func didSelectTag(for tag: CategoryEntity)
    func didTapProductLike(productID: Int, isLike: Bool)
    func didTapProductPlus(productID: Int, counter: Int)
    func didTapProductMinus(productID: Int, counter: Int)
    func didTapProductBasket(productID: Int, counter: Int)
    func didTapSliderButton()
    func didTapSortButton()
}

final class CatalogProductsViewModel: CatalogProductsViewModelProtocol {
    @Published var data: CatalogProductsVMData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()

    init(
        data: CatalogProductsVMData,
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }
}

extension CatalogProductsViewModel {

    func didSelectTag(for tag: CategoryEntity) {
        uiProperties.selectedTag = tag
    }

    func didTapSliderButton() {}

    func didTapSortButton() {}

    func didTapProductLike(productID: Int, isLike: Bool) {}

    func didTapProductPlus(productID: Int, counter: Int) {}

    func didTapProductMinus(productID: Int, counter: Int) {}

    func didTapProductBasket(productID: Int, counter: Int) {}
}

// MARK: - Reducers

extension CatalogProductsViewModel {

    func setReducers(nav: Navigation) {
        reducers.nav = nav
    }
}
