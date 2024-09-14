//
// AuthViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Combine
import Foundation

protocol AuthViewModelProtocol: ViewModelProtocol {
    // MARK: Actions
    func didTapVisibility()
    func didTapRememberMeButton()
    func didTapSignInButton()
    func didTapDontRememberButton()
    // MARK: Reducers
    func setupReducers(nav: Navigation, mainVM: MainViewModel)
    // MARK: Values
    var uiProperties: AuthViewModel.UIProperties { get set }
}

final class AuthViewModel: AuthViewModelProtocol {
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()

    private let authService = APIManager.shared.authService
    private var store: Set<AnyCancellable> = []

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
        uiProperties.buttonState = .loading
        authService.getAuthPublisher(email: uiProperties.userName, password: uiProperties.password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    print("[DEBUG]: Данные пользователя получены успешно")
                    uiProperties.buttonState = .default
                case let .failure(apiError):
                    Logger.log(kind: .error, message: apiError)
                    // TODO: Toast кинуть уведомляшку
                    uiProperties.buttonState = .default
                }
            } receiveValue: { [weak self] entity in
                guard
                    let self,
                    let token = entity.token
                else {
                    // TODO: Toast кинуть уведомляшку
                    print("[DEBUG]: Не вышло")
                    return
                }
                print("[DEBUG]: NEW TOKEN = \(token)")
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
            }.store(in: &store)
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
