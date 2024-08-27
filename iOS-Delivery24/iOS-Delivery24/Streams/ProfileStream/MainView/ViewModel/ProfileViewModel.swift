//
// ProfileViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI

protocol ProfileViewModelProtocol: ViewModelProtocol {
    // MARK: Reducers
    func setReducers(nav: Navigation, userModel: UserEntity?)
    // MARK: Actions
    func didTapRowTitle(row: ProfileViewModel.Rows)
    func didTapProduct(product: ProductEntity)
    func didTapRegistration()
    func didTapSignIn()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    @Published private(set) var data: ProfileData
    private var reducers = Reducers()

    init(data: ProfileData = .init()) {
        self.data = data
    }

    var needAuth: Bool {
        data.userModel == nil
    }
}

// MARK: - Actions

extension ProfileViewModel {

    func didTapRowTitle(row: Rows) {
        reducers.nav.addScreen(screen: row)
    }

    func didTapProduct(product: ProductEntity) {
        reducers.nav.addScreen(screen: product)
    }

    func didTapRegistration() {
        print("[DEBUG]: \(#function)")
    }

    func didTapSignIn() {
        print("[DEBUG]: \(#function)")
    }
}

// MARK: - Reducers

extension ProfileViewModel {

    func setReducers(nav: Navigation, userModel: UserEntity?) {
        reducers.nav = nav
        data.userModel = userModel?.mapper
    }
}
