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

    var products: [ProductEntity] {
        data.products.filter { product in
            uiProperties.selectedTags.contains { $0.id == product.categoryID }
        }
    }
}

extension CatalogProductsViewModel {

    func tagIsSelected(with tag: CategoryEntity) -> Bool {
        uiProperties.selectedTags.contains(tag)
    }
    
    /// Выбрали тэг
    func didSelectTag(for tag: CategoryEntity) {
        if let index = uiProperties.selectedTags.firstIndex(where: { $0 == tag }) {
            uiProperties.selectedTags.remove(at: index)
        } else {
            uiProperties.selectedTags.insert(tag)
            uiProperties.lastSelectedTag = tag
        }
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

import SwiftUI

#Preview {
    NavigationView {
        CatalogProductsView(viewModel: .mockData)
    }
}
