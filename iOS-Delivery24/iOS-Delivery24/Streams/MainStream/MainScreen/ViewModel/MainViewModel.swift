//
// MainViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import Combine

protocol MainViewModelProtocol: ViewModelProtocol {
    // MARK: Network
    func fetchData()
    // MARK: Actions
    func didTapSectionLookMore(section: MainViewModel.Section)
    func didTapSearchProduct()
    func didTapWallet()
    func didTapSelectAddress()
    func didTapLookPopularSection()
}

final class MainViewModel: MainViewModelProtocol {
    @Published var sections: [Section]
    @Published var uiProperties: UIProperties

    private var store: Set<AnyCancellable> = []
    private let productService = APIManager.shared.productService

    init(
        sections: [Section] = [],
        uiProperties: UIProperties = UIProperties()
    ) {
        self.sections = sections
        self.uiProperties = uiProperties
    }
}

// MARK: - Network

extension MainViewModel {

    func fetchData() {
        uiProperties.isAnimating = true

        let actionsPublisher = productService.getActionsProductsPublisher()
        let exclusivesPublisher = productService.getExclusivesProductPublisher()
        let hitsPublisher = productService.getHitsProductPublisher()
        let newsPublisher = productService.getNewsProductPublisher()

        actionsPublisher.combineLatest(exclusivesPublisher, hitsPublisher, newsPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("[DEBUG]: success")
                    self?.uiProperties.isAnimating = false
                case .failure(let error):
                    Logger.log(kind: .error, message: error)
                }
            } receiveValue: { [weak self] actions, exclusives, hits, news in
                guard let self else { return }
                sections = [
                    .actions(actions),
                    .exclusives(exclusives),
                    .hits(hits),
                    .news(news)
                ]
            }
            .store(in: &store)
    }
}

// MARK: - Actions

extension MainViewModel {

    func didTapSectionLookMore(section: Section) {
        print("[DEBUG]: Нажали: \(section.title)")
    }

    func didTapSearchProduct() {
        print(uiProperties.searchText)
    }

    func didTapWallet() {
        print("[DEBUG]: Нажали кошелёк")
    }

    func didTapSelectAddress() {
        print("[DEBUG]: Нажали выбрать адрес")
    }

    func didTapLookPopularSection() {
        print("[DEBUG]: Нажали секцию популярных категорий")
    }
}
