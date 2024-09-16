//
// MainViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Combine
import SwiftUI

protocol MainViewModelProtocol: ViewModelProtocol {
    // MARK: Lifecycle
    func checkBasket()
    // MARK: Network
    func fetchData()
    func addBasketProduct(body: AddBasketProductBody)
    func fetchPopcatProducts(
        categoryID: String,
        completion: @escaping DLGenericBlock<[CategoryEntity]>
    )
    // MARK: Actions
    func didTapSectionLookMore(section: MainViewModel.Section)
    func didTapSearchProduct()
    func didTapWallet()
    func didTapSelectAddress()
    func didTapLookPopularSection()
    func didTapAddInBasket(id: Int, counter: Int, coeff: Int)
    func didTapPlusInBasket(productID: Int, counter: Int, coeff: Int)
    func didTapMinusInBasket(productID: Int, counter: Int, coeff: Int)
    func didTapLike(id: Int, isLike: Bool)
    func didTapProductCard(product: ProductEntity)
    func didTapPopcatsCell(id: Int, title: String)
    // MARK: Reducers
    func updateBasketProducts(with products: [ProductEntity])
    func setUserEntity(with userEntity: UserEntity)
    func didUpdateBasketProduct(id: Int, newCounter: Int, coeff: Int)
    func didDeleteBasketProduct(id: Int)
    func didTapQuitAccount()
    func resetBasket()
}

final class MainViewModel: MainViewModelProtocol {
    @Published private(set) var data: MainVMData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()

    private var store: Set<AnyCancellable> = []
    // Словарь для хранения сабжектов по ID товаров
    private var productSubjects: [Int: PassthroughSubject<AddBasketProductBody, Never>] = [:]

    private let productService = APIManager.shared.productService
    private let bannerService = APIManager.shared.bannerService
    private let popcatsService = APIManager.shared.popcatsService
    private let userService = APIManager.shared.userService
    private let cartService = APIManager.shared.cartService
    private let catalogService = APIManager.shared.catalogService

    init(
        data: MainVMData = MainVMData(),
        uiProperties: UIProperties = UIProperties()
    ) {
        self.data = data
        self.uiProperties = uiProperties

        searchTextSubscribe()
        basketSubscribe()
    }
}

// MARK: - Subscription

private extension MainViewModel {

    func searchTextSubscribe() {
        $uiProperties
            .map(\.searchText)
            .debounce(for: 1, scheduler: DispatchQueue.global(qos: .userInteractive))
            .sink { [weak self] _ in
                self?.didTapSearchProduct()
            }.store(in: &store)
    }

    func basketSubscribe() {
        $data
            .map(\.basketBadgeCounter)
            .sink { [weak self] counter in
                self?.uiProperties.basketBadge = counter
            }.store(in: &store)
    }
}

// MARK: - Lifecycle

extension MainViewModel {

    func checkBasket() {
        #warning("""
        В общем, надо обновлять ячейки с проверкой на корзину.
        А для этого надо хранить норм модели, а для этого создавать отдельный CommontViewModel и MainViewModel
        """)
    }
}

// MARK: - Network

extension MainViewModel {

    func fetchData() {
        uiProperties.screenState = .loading
        let userToken = UserDefaultsManager.shared.userToken
        #warning("Надо доставать из UserDefaults")
        let userAddressID = data.userAddressID
        Logger.log(kind: .debug, message: "Достал токен: \(userToken ?? "None")")

        let actionsPublisher = productService.getActionsProductsPublisher()
        let exclusivesPublisher = productService.getExclusivesProductPublisher()
        let hitsPublisher = productService.getHitsProductPublisher()
        let newsPublisher = productService.getNewsProductPublisher()
        let bannerPublisher = bannerService.getBannersPublisher()
        let popcatsPublisher = popcatsService.getPopcatsPublisher()
        let userPublisher = getUserPublisher(userToken: userToken)
        let basketProductsPublisher = getBasketProductsPublisher(userToken: userToken, userAddressID: userAddressID)

        Logger.print("Делаем запрос получения продуктов")
        let combinedProductsPublisher = Publishers.CombineLatest4(
            actionsPublisher,
            exclusivesPublisher,
            hitsPublisher,
            newsPublisher
        )
        let combinedDataPublisher = Publishers.CombineLatest4(
            bannerPublisher,
            popcatsPublisher,
            userPublisher,
            basketProductsPublisher
        )
        combinedProductsPublisher.combineLatest(combinedDataPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    Logger.log(kind: .debug, message: "data fetched successfully")
                    withAnimation {
                        self?.uiProperties.screenState = .default
                    }
                case let .failure(error):
                    Logger.log(kind: .error, message: error)
                    withAnimation {
                        self?.uiProperties.screenState = .error(error)
                    }
                }
            } receiveValue: { [weak self] combinedProducts, secondCombinedData in
                guard let self else { return }
                let (actions, exclusives, hits, news) = combinedProducts
                let (bunners, popcats, userEntity, basketproducts) = secondCombinedData
                data.sections = [
                    .actions(actions),
                    .exclusives(exclusives),
                    .hits(hits),
                    .news(news)
                ]
                data.banners = bunners
                data.popcats = popcats
                data.userModel = userEntity
                data.basketProducts = basketproducts
                data.basketBadgeCounter = basketproducts.count

                // Кэшируем токен пользователя
                UserDefaultsManager.shared.userToken = userEntity?.token
            }
            .store(in: &store)
    }

    func addBasketProduct(body: AddBasketProductBody) {
        cartService.addBasketProductPublisher(body: body)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    Logger.log(message: "Товар добавлен в корзину успешно")
                    Logger.log(message: body)
                case let .failure(apiError):
                    Logger.log(kind: .error, message: apiError)
                }
            } receiveValue: { _ in
            }.store(in: &store)
    }

    /// Получение userPublisher в зависимости от наличия токена
    private func getUserPublisher(userToken: String?) -> AnyPublisher<UserEntity?, APIError> {
        let userPublisher: AnyPublisher<UserEntity?, APIError>
        if let token = userToken {
            userPublisher = userService.getUserDataPublisher(token: token)
                .map { Optional($0) }
                .catch { apiError in
                    // TODO: Кидать уведомления
                    Logger.log(kind: .error, message: apiError)
                    return Just<UserEntity?>(nil)
                }
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        } else {
            userPublisher = Just<UserEntity?>(nil)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }
        return userPublisher
    }

    private func getBasketProductsPublisher(userToken: String?, userAddressID: Int?) -> AnyPublisher<[ProductEntity], APIError> {
        guard
            let token = userToken,
            let addressID = userAddressID
        else {
            Logger.log(kind: .error, message: "Не найден токен или адрес пользователя")
            return Just<[ProductEntity]>([])
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }
        return userService.getProductBasket(token: token, addressID: addressID)
    }

    func fetchPopcatProducts(
        categoryID: String,
        completion: @escaping DLGenericBlock<[CategoryEntity]>
    ) {
        let categoryPublisher = catalogService.getCategoryPublisher(token: data.userModel?.token)

        categoryPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    Logger.log(message: "Данные каталога получены успешно")
                case let .failure(apiError):
                    // TODO: Кидать тостер
                    Logger.log(kind: .error, message: apiError)
                }
            } receiveValue: { categories in
                completion(categories)
            }
            .store(in: &store)
    }
}

// MARK: - Actions

extension MainViewModel {

    func didTapPopcatsCell(id: Int, title: String) {
        fetchPopcatProducts(categoryID: String(id)) { [weak self] categories in
            guard let self else { return }
            reducers.nav.addScreen(
                screen: Screens.lookMoreCaterogyProduct(
                    title,
                    categories.filter { $0.parentID == id }
                )
            )
        }
    }

    func didTapProductCard(product: ProductEntity) {
        reducers.nav.addScreen(screen: Screens.product(product))
    }

    func didTapSectionLookMore(section: Section) {
        reducers.nav.addScreen(screen: Screens.lookMore(section))
    }

    func didTapSearchProduct() {
        guard !uiProperties.searchText.isEmpty else { return }
        print("[DEBUG]: searhText: \(uiProperties.searchText)")
    }

    func didTapWallet() {
        print("[DEBUG]: Нажали кошелёк")
    }

    func didTapSelectAddress() {
        guard data.userModel?.token != nil else {
            uiProperties.tabItem = .profile
            return
        }
        uiProperties.sheets.showAddressView = true
    }

    func didTapLookPopularSection() {
        print("[DEBUG]: Нажали секцию популярных категорий")
        
    }

    func didTapAddInBasket(id: Int, counter: Int, coeff: Int) {
        guard data.userModel?.token != nil else {
            // TODO: Кидать тост, что надо зарегаться
            uiProperties.tabItem = .profile
            return
        }
        // TODO: Тут надо проверять, зареган ли пользователь и кидать уведомление, если это не так
        data.basketBadgeCounter += 1
        addProduct(productID: id, count: counter / coeff)
    }

    func didTapPlusInBasket(productID: Int, counter: Int, coeff: Int) {
        addProduct(productID: productID, count: counter / coeff)
    }

    func didTapMinusInBasket(productID: Int, counter: Int, coeff: Int) {
        addProduct(productID: productID, count: counter / coeff)
    }

    func didTapLike(id: Int, isLike: Bool) {
        print("[DEBUG]: \(id)")
    }

    func didUpdateBasketProduct(id: Int, newCounter: Int, coeff: Int) {
    }

    func didDeleteBasketProduct(id: Int) {
        data.basketBadgeCounter -= 1
    }
}

// MARK: - Reducers

extension MainViewModel {

    func setReducers(nav: Navigation) {
        reducers.nav = nav
    }

    func setUserEntity(with userEntity: UserEntity) {
        data.userModel = userEntity
        UserDefaultsManager.shared.userToken = userEntity.token
        Logger.log(message: "Кэшируем токен пользователя: \(userEntity.token ?? "None")")
    }

    func didTapQuitAccount() {
        data.userModel = nil
        UserDefaultsManager.shared.userToken = nil
    }
    
    /// При успешном оформлении заказа обнуляем корзину
    func resetBasket() {
        data.basketBadgeCounter = 0
        data.basketProducts = []
    }
    
    /// Обновляем данные корзины
    func updateBasketProducts(with products: [ProductEntity]) {
        data.basketProducts = products
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

    private func addProduct(productID: Int, count: Int) {
        guard
            let token = data.userModel?.token,
            let addressID = data.userAddressID
        else {
            Logger.log(kind: .error, message: "Не вышло достать token или addressID")
            // TODO: Кинуть уведомление, что ошибка добавления товара в корзину
            return
        }

        let product = AddBasketProductBody(
            token: token,
            addressID: addressID,
            productID: productID,
            count: count
        )

        // Проверяем, есть ли уже сабжект для этого товара
        if let subject = productSubjects[productID] {
            subject.send(product)
        } else {
            let subject = PassthroughSubject<AddBasketProductBody, Never>()
            productSubjects[productID] = subject
            subject
                .debounce(for: 1, scheduler: DispatchQueue.global(qos: .userInitiated))
                .sink { [weak self] product in
                    // Отправляем запрос в сеть
                    self?.addBasketProduct(body: product)
                }
                .store(in: &store)
            subject.send(product)
        }
    }
}
