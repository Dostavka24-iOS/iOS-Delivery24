//
//  RegistrationVM+Mock.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 22.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation

#if DEBUG
extension RegistrationViewModel: Mockable {

    #warning("Добавьте моковые данные")
    static let mockData = RegistrationViewModel()
}
#endif
