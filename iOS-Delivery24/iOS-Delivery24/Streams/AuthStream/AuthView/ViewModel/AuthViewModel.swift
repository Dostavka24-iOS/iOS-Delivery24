//
// AuthViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol AuthViewModelProtocol: ViewModelProtocol {
    func didTapVisibility()
    func didTapRememberMeButton()
    func didTapSignInButton()
    func didTapDontRememberButton()
    // MARK: Reducers
    func setupReducers(nav: Navigation, mainVM: MainViewModel)
}

final class AuthViewModel: AuthViewModelProtocol {
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()

    init(uiProperties: UIProperties = .init()) {
        self.uiProperties = uiProperties
    }

    var hasDisabledSignInButton: Bool {
        uiProperties.password.isEmpty 
        || uiProperties.userName.isEmpty
        || !uiProperties.hasRememberMe
    }
}

// MARK: - Actions

extension AuthViewModel {

    func didTapVisibility() {
        uiProperties.hasHiddenInput.toggle()
    }

    func didTapRememberMeButton() {
        uiProperties.hasRememberMe.toggle()
    }

    func didTapSignInButton() {
        #warning("Тут должен быть запрос /api/auth. Пока хадкод токена")
        // TODO: Тут должен быть запрос /api/auth. Пока хадкод токена
        let token = UserEntity.mockData.token
        let userEntity = UserEntity(
            id: nil,
            email: nil,
            emailVerifiedAt: nil,
            role: nil,
            createdAt: nil,
            updatedAt: nil,
            phone: nil,
            name: nil,
            address: nil,
            inn: nil,
            kpp: nil,
            addressFact: nil,
            guid: nil,
            balance: nil,
            verifyFlagEmail: nil,
            verifyFlagPhone: nil,
            verifyCodeEmail: nil,
            verifyCodePhone: nil,
            cart: nil,
            ageLimitFlag: nil,
            tgAuthCode: nil,
            tgID: nil,
            minOrder: nil,
            managerID: nil,
            token: token,
            currentAddressID: nil,
            salesFlag: nil,
            tgAuthCodeSales: nil,
            tgIdSales: nil
        )
        reducers.mainVM.setUserEntity(with: userEntity)

        reducers.nav.openPreviousScreen()
    }

    func didTapDontRememberButton() {
        print("[DEBUG]: \(#function)")
    }
}

// MARK: - Reducers

extension AuthViewModel {

    func setupReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
    }
}
