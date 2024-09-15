//
// ProfileVMModels.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension ProfileViewModel {

    struct ProfileData {
        var userModel: UserModel?
        var notifications: [BasketViewModel.NotificationInfo] = []
        var favoriteProducts: [ProductEntity] = []
    }

    struct UIProperties {}

    enum ProfileScreenState {
        case needAuth
        case screenState(ScreenState)
    }

    struct Reducers {
        var mainVM: MainViewModel!
        var nav: Navigation!
    }

    enum Screens: Hashable {
        case auth
        case registration
        case product(ProductEntity)
        case row(Rows)
    }
}
