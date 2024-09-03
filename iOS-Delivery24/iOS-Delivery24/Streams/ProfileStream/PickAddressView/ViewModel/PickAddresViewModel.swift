//
// PickAddresViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol PickAddresViewModelProtocol: ViewModelProtocol {
    // MARK: Network
    func fetch()
    // MARK: Actions
    func didPickAddress(address: PickAddresViewModel.AddressInfo)
    func didTapAddNewAddress()
    // MARK: Reducers
    func setReducers(nav: Navigation)
}

final class PickAddresViewModel: PickAddresViewModelProtocol {
    @Published var data: VMData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()

    private let addressService = APIManager.shared.addressService
    private var store: Set<AnyCancellable> = []

    init(
        data: VMData,
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }
}

// MARK: - PickAddresViewModelProtocol

extension PickAddresViewModel {

    func fetch() {
        let addressPublisher = addressService.getAddressPublisher(token: data.userToken)
        addressPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    Logger.log(message: "Данные по адресам получены успешно")
                case .failure(let apiError):
                    Logger.log(kind: .error, message: apiError)
                }
            } receiveValue: { [weak self] addressEntity in
                self?.data.addreses = addressEntity.compactMap(\.mapper)
            }.store(in: &store)
    }

    func didPickAddress(address: AddressInfo) {
        uiProperties.selectedAddress = address
    }

    func didTapAddNewAddress() {
        reducers.nav.addScreen(screen: Screens.addAddress)
    }

    func setReducers(nav: Navigation) {
        reducers.nav = nav
    }
}
