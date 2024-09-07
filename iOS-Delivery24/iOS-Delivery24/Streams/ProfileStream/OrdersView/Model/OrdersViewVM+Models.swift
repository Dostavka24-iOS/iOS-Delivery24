//
//  OrdersViewVM+Models.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation

extension OrdersViewModel {

    struct OrdersViewVMData {
        var orders: [OrderEntity] = []
        var moneyCount = ""
    }

    struct UIProperties {
        var searchText = ""
        var screenState: ScreenState = .initial
    }

    struct Reducers {
        var nav: Navigation!
        var mainVM: MainViewModel!
    }

    enum Screens: Hashable {
    }
}
