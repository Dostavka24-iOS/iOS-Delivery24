//
// URLRequest+Extensions.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 30.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension URLRequest {

    mutating func setValue(_ value: HTTPValues.ContentType, for header: HTTPValues.Header) {
        setValue(value.rawValue, forHTTPHeaderField: header.rawValue)
    }

    mutating func setValue(_ value: String, for header: HTTPValues.Header) {
        setValue(value, forHTTPHeaderField: header.rawValue)
    }
}
