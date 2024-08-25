//
// CategoryViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol CategoryViewModelProtocol: ViewModelProtocol {

    // MARK: Values
    var data: CategoryViewModel.CategoryVMData { get }
    var uiProperties: CategoryViewModel.UIProperties { get set }
    // MARK: Actions
    func didTapLookAllPopcatProducts()
    func didTapLikeProduct(id: Int)
    func didTapBasketProduct(id: Int)
    // MARK: Network
    func fetch()
}

final class CategoryViewModel: CategoryViewModelProtocol {

    @Published private(set) var data: CategoryVMData
    @Published var uiProperties: UIProperties

    private var store: Set<AnyCancellable> = []
    private let categoryService = APIManager.shared.categoryService

    init(
        data: CategoryVMData,
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }
}

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
                case .failure(let apiError):
                    Logger.log(kind: .error, message: apiError)
                    uiProperties.screenState = .error(apiError)
                }
            } receiveValue: { [weak self] categories in
                guard let self else { return }
                data.categories = categories
                data.parentCategories = categories.filter { $0.parentID == 0 }
                // FIXME: Заменить на бэк
                data.popProducts = [MainViewModel.Section].fakeEntityProducts
            }
            .store(in: &store)

    }

    func didTapLookAllPopcatProducts() {
        Logger.print("нажали см все")
    }

    func didTapLikeProduct(id: Int) {
        print("[DEBUG]: Нажали лайк: \(id)")
    }

    func didTapBasketProduct(id: Int) {
        print("[DEBUG]: нажали корзину: \(id)")
    }
}

extension CategoryViewModel {

    struct CategoryVMData {
        var userToken: String
        var categories: [CategoryEntity] = []
        var parentCategories: [CategoryEntity] = []
        var popProducts: [ProductEntity] = []
    }

    struct UIProperties {
        var screenState: ScreenState = .initial
        var searchText = ""

        enum ScreenState {
            case initial
            case error(APIError)
            case loading
            case `default`
        }
    }
}

import SwiftUI

#Preview {
    CategoryView(viewModel: .mockData)
}
