//
// String+Extenstions.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 14.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension String {

    var capitalizingFirstLetter: String {
        prefix(1).capitalized + dropFirst()
    }
}
