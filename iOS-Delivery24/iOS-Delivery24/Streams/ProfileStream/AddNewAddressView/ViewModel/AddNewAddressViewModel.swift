//
// AddNewAddressViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol AddNewAddressViewModelProtocol: ViewModelProtocol {
}

final class AddNewAddressViewModel: AddNewAddressViewModelProtocol {
    @Published var uiProperties: UIProperties

    init(uiProperties: UIProperties = .init()) {
        self.uiProperties = uiProperties
    }
}

extension AddNewAddressViewModel {
}
