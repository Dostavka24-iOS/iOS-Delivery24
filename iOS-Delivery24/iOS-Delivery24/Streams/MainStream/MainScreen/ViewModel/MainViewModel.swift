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
    func didTapAddInBasket(id: Int)
    func didTapLike(id: Int)
}

final class MainViewModel: MainViewModelProtocol {
    @Published private(set) var data: MainVMData
    @Published var uiProperties: UIProperties

    private var store: Set<AnyCancellable> = []
    private let productService = APIManager.shared.productService
    private let bannerService = APIManager.shared.bannerService
    private let popcatsService = APIManager.shared.popcatsService

    init(
        data: MainVMData = .init(),
        uiProperties: UIProperties = UIProperties()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }
}

// MARK: - Network

extension MainViewModel {

    func fetchData() {
        guard uiProperties.screenState == .initial else {
            Logger.print("Данные уже получены раннее")
            return
        }

        uiProperties.screenState = .loading

        let actionsPublisher = productService.getActionsProductsPublisher()
        let exclusivesPublisher = productService.getExclusivesProductPublisher()
        let hitsPublisher = productService.getHitsProductPublisher()
        let newsPublisher = productService.getNewsProductPublisher()
        let bannerPublisher = bannerService.getBannersPublisher()
        let popcatsPublisher = popcatsService.getPopcatsPublisher()

        Logger.print("Делаем запрос получения продуктов")
        let combinedProductsPublisher = Publishers.CombineLatest4(actionsPublisher, exclusivesPublisher, hitsPublisher, newsPublisher)
        combinedProductsPublisher.combineLatest(bannerPublisher, popcatsPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    Logger.log(message: "data fetched successfully")
                    self?.uiProperties.screenState = .default
                case .failure(let error):
                    Logger.log(kind: .error, message: error)
                    self?.uiProperties.screenState = .error(error)
                }
            } receiveValue: { [weak self] combinedProducts, bunners, popcats in
                guard let self else { return }
                let (actions, exclusives, hits, news) = combinedProducts
                data.sections = [
                    .actions(actions),
                    .exclusives(exclusives),
                    .hits(hits),
                    .news(news)
                ]
                data.banners = bunners
                data.popcats = popcats
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

    func didTapAddInBasket(id: Int) {
        print("[DEBUG]: \(id)")
    }

    func didTapLike(id: Int) {
        print("[DEBUG]: \(id)")
    }
}
