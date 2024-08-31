//
// HTTPValues.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 30.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

enum HTTPValues {

    enum ContentType: String {
        case json = "application/json"
        case urlEncoded = "application/x-www-form-urlencoded"
        case xml = "application/xml"
        case plainText = "text/plain"
    }

    enum Header: String {
        case contentType = "Content-Type"
        case accept = "Accept"
        case authorization = "Authorization"
        case userAgent = "User-Agent"
    }
}
