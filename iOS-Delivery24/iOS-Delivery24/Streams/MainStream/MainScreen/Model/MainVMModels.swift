//
// MainVMModels.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

// MARK: - MainVMData

extension MainViewModel {

    struct MainVMData {
        var userModel: UserEntity?
        var sections: [Section] = []
        var banners: [BannerEntity] = []
        var popcats: [PopcatsEntity] = []
    }
}

// MARK: - UIProperties

extension MainViewModel {

    struct UIProperties {
        var searchText = ""
        var size: CGSize = .zero
        var lastSelectedSection: String?
        var screenState = ScreenState.initial
    }

    struct Reducers {
        var nav: Navigation!
    }
}

// MARK: - Screens

extension MainViewModel {

    enum Screens: Identifiable, Hashable {
        case product(ProductEntity)
    }
}

extension MainViewModel.Screens {

    var id: String {
        switch self {
        case .product: "product"
        }
    }

    static func == (lhs: MainViewModel.Screens, rhs: MainViewModel.Screens) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
