//
// PickAddresViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol PickAddresViewModelProtocol: ViewModelProtocol {
    func didPickAddress(address: PickAddresViewModel.AddressInfo)
    func didTapAddNewAddress()
}

final class PickAddresViewModel: PickAddresViewModelProtocol {
    @Published var data: VMData
    @Published var uiProperties: UIProperties

    init(
        data: VMData = .init(),
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }
}

// MARK: - Actions

extension PickAddresViewModel {

    func didPickAddress(address: AddressInfo) {
        uiProperties.selectedAddress = address
    }

    func didTapAddNewAddress() {
        print("[DEBUG]: Нажали кнопку добавить адрес")
    }
}
