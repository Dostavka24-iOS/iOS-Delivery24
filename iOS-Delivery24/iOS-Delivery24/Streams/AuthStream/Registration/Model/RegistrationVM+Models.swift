//
//  RegistrationVM+Models.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 22.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation

extension RegistrationViewModel {

    struct RegistrationVMData {
    }

    struct UIProperties {
        var inputEmail = ""
    }

    struct Reducers {
        var nav: Navigation!
        var mainVM: MainViewModel!
    }

    enum Screens: Hashable {
    }
}
