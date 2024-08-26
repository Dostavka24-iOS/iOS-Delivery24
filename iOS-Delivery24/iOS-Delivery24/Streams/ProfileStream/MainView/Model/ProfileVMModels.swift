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
        var notifications: [BasketViewModel.NotificationInfo] = []
        var favoriteProducts: [ProductEntity] = []
    }

    struct Reducers {
        var nav: Navigation!
    }
}
