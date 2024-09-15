//
// PostPublisher.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 07.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Combine
import Foundation

/// Базовая функция создания паблешера для метода `POST`
/// - Parameters:
///   - url: URL путь до ручки
///   - body: Боди запроса
/// - Returns: Паблишер с декодированными данными
func postPublisher<T: Decodable>(url: URL, body: [String: Any]) -> AnyPublisher<T, APIError> {
    var request = URLRequest(url: url)
    request.httpMethod = HTTPMethod.post.rawValue
    request.setValue(.json, for: .contentType)
    request.setValue(.json, for: .accept)
    do {
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        request.httpBody = bodyData
        return URLSession.shared.dataTaskPublisher(for: request)
            .validateResponse()
            .decode()
            .eraseToAnyPublisher()
    } catch {
        return Fail(error: APIError.error(error)).eraseToAnyPublisher()
    }
}

func postVoidPubliser(url: URL, body: [String: Any]) -> AnyPublisher<Void, APIError> {
    var request = URLRequest(url: url)
    request.httpMethod = HTTPMethod.post.rawValue
    request.setValue(.json, for: .contentType)
    request.setValue(.json, for: .accept)
    do {
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        request.httpBody = bodyData
        return URLSession.shared.dataTaskPublisher(for: request)
            .validateResponse()
            .map { _ in () }
            .eraseToAnyPublisher()
    } catch {
        return Fail(error: APIError.error(error)).eraseToAnyPublisher()
    }
}
