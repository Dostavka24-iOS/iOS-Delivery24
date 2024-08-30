//
// ProfileViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

protocol ProfileViewModelProtocol: ViewModelProtocol {
    // MARK: Lifecycle & Reducers
    func onAppearAndsetReducers(nav: Navigation, mainVM: MainViewModel)
    // MARK: Network
    func fetchUserData(token: String)
    // MARK: Actions
    func didTapRowTitle(row: ProfileViewModel.Rows)
    func didTapProduct(product: ProductEntity)
    func didTapRegistration()
    func didTapSignIn()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    @Published private(set) var data: ProfileData
    @Published private(set) var profileScreenState: ProfileScreenState
    private var reducers = Reducers()

    private var store: Set<AnyCancellable> = []
    private let userService = APIManager.shared.userService

    init(
        data: ProfileData = .init(),
        profileScreenState: ProfileScreenState = .needAuth
    ) {
        self.data = data
        self.profileScreenState = profileScreenState
    }

}

// MARK: - Network

extension ProfileViewModel {

    func fetchUserData(token: String) {
        profileScreenState = .screenState(.loading)
        let userPublisher = userService.getUserDataPublisher(token: token)
        userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    Logger.log(message: "Данные о пользователе получены успешно")
                    profileScreenState = .screenState(.default)
                case .failure(let apiError):
                    Logger.log(kind: .error, message: "Ошибка получения данных о пользователе\n\(apiError)")
                    profileScreenState = .screenState(.error(apiError))
                }
            } receiveValue: { [weak self] user in
                guard let self else { return }
                Logger.log(message: user)
                reducers.mainVM.setUserEntity(with: user)
                data.userModel = user.mapper
            }.store(in: &store)
    }
}

// MARK: - Actions

extension ProfileViewModel {

    func didTapRowTitle(row: Rows) {
        // Если нажали кнопку выйти, очищаем данные и открываем авторизацию
        if row == .quit {
            reducers.mainVM.didTapQuitAccount()
            profileScreenState = .needAuth
            return
        }
        reducers.nav.addScreen(screen: Screens.row(row))
    }

    func didTapProduct(product: ProductEntity) {
        reducers.nav.addScreen(screen: Screens.product(product))
    }

    func didTapRegistration() {
        reducers.nav.addScreen(screen: Screens.registration)
    }

    func didTapSignIn() {
        reducers.nav.addScreen(screen: Screens.auth)
    }
}

// MARK: - Lifecycle & Reducers

extension ProfileViewModel {

    func onAppearAndsetReducers(nav: Navigation, mainVM: MainViewModel) {
        print("[DEBUG]: \(#function)")
        reducers.nav = nav
        reducers.mainVM = mainVM
        data.userModel = mainVM.data.userModel?.mapper

        guard
            let userDefaultsToken = UserDefaultsManager.shared.userToken
        else {
            profileScreenState = .needAuth
            return
        }

        // Если userModel is Nil, то показываем экран с кнопкой регистрации
        let mainUserEntity = mainVM.data.userModel
        guard
            let token = mainUserEntity?.token,
            token == userDefaultsToken
        else {
            profileScreenState = .needAuth
            return
        }

        // Если данные о пользователе уже есть, запрос делать не надо
        guard data.userModel == nil else {
            profileScreenState = .screenState(.default)
            return
        }

        // Если данных не было, идём в сеть
        fetchUserData(token: token)
    }
}
