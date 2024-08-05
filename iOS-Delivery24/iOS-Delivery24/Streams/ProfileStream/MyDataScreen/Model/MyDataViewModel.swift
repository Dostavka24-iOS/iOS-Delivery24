//
// MyDataViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol MyDataViewModelProtocol: ViewModelProtocol {

}

extension MyDataViewModel {

    struct UIProperties {
        var emailInput = ""
        var passwordInput = ""
        var phoneInput = ""
        var confirmationСodeInput = ""
    }
}

final class MyDataViewModel: MyDataViewModelProtocol {
    var uiProperties: UIProperties

    init(uiProperties: UIProperties = .init()) {
        self.uiProperties = uiProperties
    }
}

// MARK: - Actions

extension MyDataViewModel {

}
