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
    // MARK: Lifecycle
    func checkBasket()
    // MARK: Network
    func fetchData()
    // MARK: Actions
    func didTapSectionLookMore(section: MainViewModel.Section)
    func didTapSearchProduct()
    func didTapWallet()
    func didTapSelectAddress()
    func didTapLookPopularSection()
    func didTapAddInBasket(id: Int, counter: Int)
    func didTapPlusInBasket(productID: Int, counter: Int)
    func didTapMinusInBasket(productID: Int, counter: Int)
    func didTapLike(id: Int, isLike: Bool)
    func didTapProductCard(product: ProductEntity)
    // MARK: Reducers
    func setUserEntity(with userEntity: UserEntity)
    func didUpdateBasketProduct(id: Int, newCounter: Int)
    func didDeleteBasketProduct(id: Int)
}

final class MainViewModel: MainViewModelProtocol {
    @Published private(set) var data: MainVMData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()

    private var store: Set<AnyCancellable> = []
    private let productService = APIManager.shared.productService
    private let bannerService = APIManager.shared.bannerService
    private let popcatsService = APIManager.shared.popcatsService
    private let userService = APIManager.shared.userService

    init(
        data: MainVMData = .init(),
        uiProperties: UIProperties = UIProperties()
    ) {
        self.data = data
        self.uiProperties = uiProperties

        $uiProperties
            .map(\.searchText)
            .debounce(for: 1, scheduler: DispatchQueue.global(qos: .userInteractive))
            .sink { [weak self] _ in
                self?.didTapSearchProduct()
            }
            .store(in: &store)

        $data
            .map(\.basketProducts)
            .sink { [weak self] dict in
                self?.uiProperties.basketBadge = dict.count
            }
            .store(in: &store)
    }
}

// MARK: - Lifecycle

extension MainViewModel {

    func checkBasket() {
    }
}

extension MainViewModel {

    func setReducers(nav: Navigation) {
        reducers.nav = nav
    }

    func didUpdateBasketProduct(id: Int, newCounter: Int) {
        data.basketProducts[id] = newCounter
    }

    func didDeleteBasketProduct(id: Int) {
        data.basketProducts.removeValue(forKey: id)
    }
}

// MARK: - Network

extension MainViewModel {

    func fetchData() {
        uiProperties.screenState = .loading

        let actionsPublisher = productService.getActionsProductsPublisher()
        let exclusivesPublisher = productService.getExclusivesProductPublisher()
        let hitsPublisher = productService.getHitsProductPublisher()
        let newsPublisher = productService.getNewsProductPublisher()
        let bannerPublisher = bannerService.getBannersPublisher()
        let popcatsPublisher = popcatsService.getPopcatsPublisher()
        let userPublisher = getUserPublisher()

        Logger.print("Делаем запрос получения продуктов")
        let combinedProductsPublisher = Publishers.CombineLatest4(actionsPublisher, exclusivesPublisher, hitsPublisher, newsPublisher)
        combinedProductsPublisher.combineLatest(bannerPublisher, popcatsPublisher, userPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    Logger.log(kind: .debug, message: "data fetched successfully")
                    withAnimation {
                        self?.uiProperties.screenState = .default
                    }
                case .failure(let error):
                    Logger.log(kind: .error, message: error)
                    withAnimation {
                        self?.uiProperties.screenState = .error(error)
                    }
                }
            } receiveValue: { [weak self] combinedProducts, bunners, popcats, userEntity in
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
                data.userModel = userEntity
                // Кэшируем токен пользователя
                UserDefaultsManager.shared.userToken = userEntity?.token
            }
            .store(in: &store)
    }
    
    /// Получение userPublisher в зависимости от наличия токена
    private func getUserPublisher() -> AnyPublisher<UserEntity?, APIError> {
        let userPublisher: AnyPublisher<UserEntity?, APIError>
        let userToken = UserDefaultsManager.shared.userToken
        if let token = userToken {
            userPublisher = userService.getUserDataPublisher(token: token)
                .map { Optional($0) }
                .eraseToAnyPublisher()
        } else {
            userPublisher = Just<UserEntity?>(nil)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }
        return userPublisher
    }
}

// MARK: - Actions

extension MainViewModel {

    func didTapProductCard(product: ProductEntity) {
        reducers.nav.addScreen(screen: Screens.product(product))
    }

    func didTapSectionLookMore(section: Section) {
        print("[DEBUG]: Нажали: \(section.title)")
    }

    func didTapSearchProduct() {
        guard !uiProperties.searchText.isEmpty else { return }
        print("[DEBUG]: searhText: \(uiProperties.searchText)")
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

    func didTapAddInBasket(id: Int, counter: Int) {
        data.basketProducts[id] = counter
        // TODO: Тут надо бы обнолять что-то или кидать запрос
    }

    func didTapPlusInBasket(productID: Int, counter: Int) {
        data.basketProducts[productID] = counter
        // TODO: Тут надо бы обнолять что-то или кидать запрос
    }

    func didTapMinusInBasket(productID: Int, counter: Int) {
        data.basketProducts[productID] = counter
        // TODO: Тут надо бы обнолять что-то или кидать запрос
    }

    func didTapLike(id: Int, isLike: Bool) {
        print("[DEBUG]: \(id)")
    }
}

// MARK: - Reducers

extension MainViewModel {

    func setUserEntity(with userEntity: UserEntity) {
        data.userModel = userEntity
        UserDefaultsManager.shared.userToken = userEntity.token
    }
}

// MARK: - Helper

extension MainViewModel {

    func getProductByID(for id: Int) -> ProductEntity? {
        for section in data.sections {
            if let product = section.products.first(where: { $0.id == id }) {
                return product
            }
        }
        return nil
    }
}

// MARK: - Preview

#Preview("Portrait") {
    MainView()
        .environmentObject(MainViewModel.mockData)
}
