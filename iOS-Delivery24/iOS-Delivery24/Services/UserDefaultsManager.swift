//
// UserDefaultsManager.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

final class UserDefaultsManager {

    static let shared = UserDefaultsManager()
    fileprivate enum Keys {}

    private init() {}

    var userToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.UserKeys.token.rawValue)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.UserKeys.token.rawValue)
        }
    }
}

// MARK: - Keys

fileprivate extension UserDefaultsManager.Keys {

    enum UserKeys: String {
        case token
    }
}
