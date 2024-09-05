//
//  OrdersViewVM+Mock.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation

#if DEBUG
extension OrdersViewViewModel: Mockable {

    #warning("Добавьте моковые данные")
    static let mockData = OrdersViewViewModel()
}
#endif
