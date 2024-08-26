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
    func setReducers(nav: Navigation)
    // MARK: Actions
    func didTapRowTitle(row: ProfileViewModel.Rows)
    func didTapProduct(product: ProductEntity)
}

final class ProfileViewModel: ProfileViewModelProtocol {
    private(set) var data: ProfileData
    private var reducers = Reducers()

    init(data: ProfileData = .init()) {
        self.data = data
    }
}

// MARK: - Reducers

extension ProfileViewModel {

    func setReducers(nav: Navigation) {
        reducers.nav = nav
    }

    func didTapRowTitle(row: Rows) {
        reducers.nav.addScreen(screen: row)
    }

    func didTapProduct(product: ProductEntity) {
        print("[DEBUG]: \(product.id)")
        reducers.nav.addScreen(screen: product)
    }
}
