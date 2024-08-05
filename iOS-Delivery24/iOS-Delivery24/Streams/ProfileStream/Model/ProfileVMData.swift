//
// ProfileVMData.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension ProfileViewModel {

    struct ProfileData {
        var notifications: [BasketViewModel.NotificationInfo] = []
        var favoriteProducts: [MainViewModel.Product] = []
    }
}
