//
// AuthVMModels.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension AuthViewModel {

    struct UIProperties {
        var userName = ""
        var password = ""
        var hasHiddenInput = true
        var hasRememberMe = false
        var buttonState: ButtonState = .default
    }

    struct Reducers {
        var nav: Navigation!
        var mainVM: MainViewModel!
    }
}
