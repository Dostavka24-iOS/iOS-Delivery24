//
// PickAddresVMData.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension PickAddresViewModel {

    struct VMData {
        var addreses: [AddressInfo] = []
        var userToken: String
    }

    struct AddressInfo: Identifiable, Equatable {
        var id: Int
        var locationTitle: String
    }

    struct Reducers {
        var nav: Navigation!
    }

    enum Screens: Hashable {
        case addAddress
    }
}
