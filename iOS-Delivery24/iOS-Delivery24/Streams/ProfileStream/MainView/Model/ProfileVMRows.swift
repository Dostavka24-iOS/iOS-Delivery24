//
// ProfileVMRows.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension ProfileViewModel {

    enum Rows: String, CaseIterable, Identifiable, Hashable {
        case userData
        case favorites
        case address
        case orders
        case faq
        case telegramBot
        case info
        case feedback
        case quit
    }
}

extension ProfileViewModel.Rows {

    var id: String { locolizedString }

    var locolizedString: String {
        switch self {
        case .userData:
            return String(localized: "данные пользователя")
        case .favorites:
            return String(localized: "избранное")
        case .address:
            return String(localized: "адреса доставки")
        case .orders:
            return String(localized: "заказы")
        case .faq:
            return String(localized: "FAQ")
        case .telegramBot:
            return String(localized: "Telegram Bot")
        case .info:
            return String(localized: "О компании")
        case .feedback:
            return String(localized: "Связаться с нами")
        case .quit:
            return String(localized: "Выйти")
        }
    }

    var icon: Image {
        switch self {
        case .userData:
            return Image(.profile)
        case .favorites:
            return Image(.favorite)
        case .address:
            return Image(.map)
        case .orders:
            return Image(.car)
        case .faq:
            return Image(.faq)
        case .telegramBot:
            return Image(.telegramBot)
        case .info:
            return Image(.info)
        case .feedback:
            return Image(.feedback)
        case .quit:
            return Image(.quit)
        }
    }
}
