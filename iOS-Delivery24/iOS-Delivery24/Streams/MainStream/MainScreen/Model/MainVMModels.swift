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
        #warning("Надо сделать опционалом и в методу onAppear откуда-то доставать")
        var userAddressID: Int? = 1995
        var sections: [Section] = []
        var banners: [BannerEntity] = []
        var popcats: [PopcatsEntity] = []
        var basketBadgeCounter = 0
        var basketProducts: [ProductEntity] = []
    }
}

// MARK: - UIProperties

extension MainViewModel {

    struct UIProperties {
        var tabItem: TabBarItem = .house
        var searchText = ""
        var size: CGSize = .zero
        var lastSelectedSection: String?
        var screenState = ScreenState.initial
        var basketBadge = 0
        var sheets = Sheets()
    }
}

extension MainViewModel.UIProperties {

    struct Sheets {
        var showAddressView = false
    }
}

// MARK: - Reducers

extension MainViewModel {

    struct Reducers {
        var nav: Navigation!
    }
}

// MARK: - Screens

extension MainViewModel {

    enum Screens: Identifiable, Hashable, Equatable {
        case product(ProductEntity)
        case lookMore(Section)
        case lookMoreCaterogyProduct(String, [CategoryEntity])
    }
}

extension MainViewModel.Screens {

    var id: String {
        switch self {
        case .product: "product"
        case .lookMore: "lookMore"
        case .lookMoreCaterogyProduct: "lookMoreCaterogyProduct"
        }
    }

    static func == (lhs: MainViewModel.Screens, rhs: MainViewModel.Screens) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
