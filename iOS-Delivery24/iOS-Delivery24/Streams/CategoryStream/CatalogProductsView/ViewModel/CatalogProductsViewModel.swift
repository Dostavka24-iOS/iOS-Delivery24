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
    func setReducers(nav: Navigation, mainVM: MainViewModel)
    // MARK: Actions
    func didTapProductCard(for product: CategoryProductEntity)
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

    private var store: Set<AnyCancellable> = []
    private let catalogService = APIManager.shared.catalogService

    init(
        data: CatalogProductsVMData,
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }

    var products: [CategoryProductEntity] {
        data.products.filter { product in
            uiProperties.selectedTags.contains { $0.id == product.categoryID }
        }
    }
}

// MARK: - Network

extension CatalogProductsViewModel {

    func fetchCategoryProducts(token: String?, categoryID: Int) {
        Logger.log(kind: .debug, message: "Делаю запрос в сеть для получения продуктов категории: \(categoryID)")
        catalogService.getCategoryProductsPubliser(
            token: token,
            categoryID: String(categoryID)
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            guard let self else { return }
            switch completion {
            case .finished:
                Logger.log(message: "Данные категории получены успешно")
                uiProperties.screenState = .default
            case .failure(let apiError):
                Logger.log(kind: .error, message: apiError)
                uiProperties.screenState = .default
            }
        } receiveValue: { [weak self] products in
            guard let self else { return }
            data.products.append(contentsOf: products)
            // Запоминаем, что для этой категории товары получены
            data.receivedtedCategories.insert(categoryID)
        }.store(in: &store)
    }
}

// MARK: - Actions

extension CatalogProductsViewModel {
    
    func didTapProductCard(for product: CategoryProductEntity) {
        let productEntity = product.mapperToProductEntity
        reducers.nav.addScreen(screen: Screens.product(productEntity))
    }

    /// Флаг при выбранном теге
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

            // Делаем запрос в сеть только в случае, если для данной категории товары ещё не были полученны
            guard
                let categoryID = tag.id,
                !data.receivedtedCategories.contains(categoryID)
            else {
                Logger.log(kind: .debug, message: "Данные этой категории уже были получены ранее")
                return
            }

            uiProperties.screenState = .loading
            fetchCategoryProducts(
                token: reducers.mainVM.data.userModel?.token,
                categoryID: categoryID
            )
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

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
        guard let categoryID = uiProperties.lastSelectedTag?.id else {
            return
        }
        fetchCategoryProducts(token: mainVM.data.userModel?.token, categoryID: categoryID)
    }
}
