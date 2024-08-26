//
// CategoryViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

protocol CategoryViewModelProtocol: ViewModelProtocol {

    // MARK: Values
    var data: CategoryViewModel.CategoryVMData { get }
    var uiProperties: CategoryViewModel.UIProperties { get set }
    var isLoading: Bool { get }
    // MARK: Actions
    func didTapLookAllPopcatProducts()
    func didTapLikeProduct(id: Int)
    func didTapBasketProduct(id: Int)
    // MARK: Network
    func fetch()
}

final class CategoryViewModel: CategoryViewModelProtocol {

    @Published var uiProperties: UIProperties
    @Published private(set) var data: CategoryVMData

    private var store: Set<AnyCancellable> = []
    private let categoryService = APIManager.shared.categoryService

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
                    withAnimation {
                        self.uiProperties.screenState = .default
                    }
                case .failure(let apiError):
                    Logger.log(kind: .error, message: apiError)
                    withAnimation {
                        self.uiProperties.screenState = .error(apiError)
                    }
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
}

// MARK: - Actions

extension CategoryViewModel {

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
