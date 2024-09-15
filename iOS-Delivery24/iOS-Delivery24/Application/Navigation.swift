//
// Navigation.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import NavigationStackBackport
import SwiftUI

final class Navigation: ObservableObject {
    @Published var path = NavigationStackBackport.NavigationPath()
}

extension Navigation {

    func addScreen<T: Hashable>(screen: T) {
        path.append(screen)
    }

    func openPreviousScreen() {
        guard path.count - 1 >= 0 else { return }
        path.removeLast()
    }

    func goToRoot() {
        while path.count > 0 {
            path.removeLast()
        }
    }
}

// MARK: - TabBarItem

enum TabBarItem: String, CaseIterable {
    case house = "Главная"
    case catalog = "Каталог"
    case cart = "Корзина"
    case profile = "Профиль"

    var image: Image {
        let image = switch self {
        case .house:
            Image(.home)
        case .catalog:
            Image(.magnifier)
        case .cart:
            Image(.cart)
        case .profile:
            Image(.profileBar)
        }
        return image.renderingMode(.template)
    }
}
