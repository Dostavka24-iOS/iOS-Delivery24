//
// UserModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct UserModel {
    let id: Int
    let email: String
    let phone: String
    let name: String
    let inn: String
    let kpp: String
    let token: String
}

// MARK: - Mock Data

#if DEBUG
extension UserModel: Mockable {

    static let mockData = UserModel(
        id: 1,
        email: "dimapermyakov55@gmail.com",
        phone: "+7(916)855-99-42",
        name: "mightyK1ngRichard",
        inn: "124523567329",
        kpp: "123456789",
        token: "wFbiEwN3fRrujnou"
    )
}
#endif
