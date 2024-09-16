//
// CategoryViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

protocol CategoryViewModelProtocol: ViewModelProtocol {

    // MARK: Values
    var data: CategoryViewModel.CategoryVMData { get }
    var uiProperties: CategoryViewModel.UIProperties { get set }
    var isLoading: Bool { get }
    // MARK: Actions
    func didTapLookAllPopcatProducts()
    func didTapLikeProduct(id: Int, isLike: Bool)
    func didTapBasketProduct(id: Int, counter: Int)
    func didTapParentCategory(id: Int)
    func didTapProductCard(with product: ProductEntity)
    // MARK: Network
    func fetch()
    // MARK: Reducers
    func setReducers(nav: Navigation, mainVM: MainViewModel)
}

final class CategoryViewModel: CategoryViewModelProtocol {

    @Published var uiProperties: UIProperties
    @Published private(set) var data: CategoryVMData

    private var reducers = Reducers()
    private var store: Set<AnyCancellable> = []
    private let categoryService = APIManager.shared.catalogService

    init(
        data: CategoryVMData,
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
        subscribeSearchText()
    }

    var isLoading: Bool {
        uiProperties.screenState == .loading
    }
}

// MARK: - Network

extension CategoryViewModel {

    func fetch() {
        uiProperties.screenState = .loading

        let categoryPublisher = categoryService.getCategoryPublisher(token: data.userToken)

        categoryPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    Logger.log(message: "Данные каталога получены успешно")
                    uiProperties.screenState = .default
                case let .failure(apiError):
                    Logger.log(kind: .error, message: apiError)
                    uiProperties.screenState = .error(apiError)
                }
            } receiveValue: { [weak self] categories in
                guard let self else { return }
                data.categories = categories
                data.parentCategories = categories.filter { $0.parentID == 0 }
                // FIXME: Заменить на бэк (Должна появиться ручка популярных товаров)
//                data.popProducts = .mockData
            }
            .store(in: &store)
    }
}

// MARK: - Actions

extension CategoryViewModel {

    func didTapParentCategory(id: Int) {
        guard let category = data.parentCategories.first(where: { $0.id == id }) else {
            Logger.log(kind: .error, message: "Категория с id=\(id) не найдена")
            return
        }

        reducers.nav.addScreen(
            screen: Screens.categoryList(
                category,
                data.categories.filter { $0.parentID == id }
            )
        )
    }

    func didTapProductCard(with product: ProductEntity) {
        reducers.nav.addScreen(screen: Screens.productScreen(product))
    }

    func didTapLookAllPopcatProducts() {
        reducers.nav.addScreen(screen: Screens.allProductsScreen(data.popProducts))
    }

    func didTapLikeProduct(id: Int, isLike: Bool) {
        print("[DEBUG]: Нажали лайк: \(id) isLike: \(isLike)")
    }

    func didTapBasketProduct(id: Int, counter: Int) {
        print("[DEBUG]: нажали корзину: \(id)")
    }
}

// MARK: - Reducers

extension CategoryViewModel {

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        if mainVM.data.sections.count > 2 {
            data.popProducts = mainVM.data.sections[2].products
        }
    }
}

// MARK: - Inner Methods

private extension CategoryViewModel {

    func subscribeSearchText() {
        $uiProperties
            .map(\.searchText)
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { text in
                guard !text.isEmpty else { return }
                print("[DEBUG]: \(text)")
            }
            .store(in: &store)
    }
}
