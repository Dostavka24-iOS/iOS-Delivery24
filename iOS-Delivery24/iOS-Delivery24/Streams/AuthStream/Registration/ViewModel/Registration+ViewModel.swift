//
//  Registration+ViewModel.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 22.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation
import Combine

protocol RegistrationViewModelProtocol: ViewModelProtocol {
    // MARK: Networks
    // MARK: Actions
    func didTapCloseScreen()
    func didTapGetPassword()
    // MARK: Reducers
    func setReducers(nav: Navigation, mainVM: MainViewModel)
    // MARK: Values
    var data: RegistrationViewModel.RegistrationVMData { get }
    var uiProperties: RegistrationViewModel.UIProperties { get set }
}

final class RegistrationViewModel: RegistrationViewModelProtocol {
    @Published private(set) var data: RegistrationVMData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()
    private var store: Set<AnyCancellable> = []

    init(
        data: RegistrationVMData = .init(),
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }

    var getPasswordButtonIsDisable: Bool {
        // FIXME: Тут должна быть проверка на корректность email
        uiProperties.inputEmail.isEmpty
    }
}

// MARK: - Network

extension RegistrationViewModel {
}

// MARK: - Actions

extension RegistrationViewModel {

    func didTapCloseScreen() {}

    func didTapGetPassword() {}
}

// MARK: - Reducers

extension RegistrationViewModel {

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
    }
}
