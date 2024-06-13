//
// MainVM+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension MainViewModel: Mockable {

    static let mockData: MainViewModel = MainViewModel(sections: .mockData)
}
#endif
