//
// OrderService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 06.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol OrderServiceProtocol {
    func makeOrderPublisher(body: OrderBody) -> AnyPublisher<Void, APIError>
}

final class OrderService: OrderServiceProtocol {

    static let shared: OrderServiceProtocol = OrderService()
    private let router = Router.Order.Paths.self

    private init() {}

    func makeOrderPublisher(body: OrderBody) -> AnyPublisher<Void, APIError> {
        guard let url = URL(string: router.add.urlPath) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(.json, for: .contentType)
        request.setValue(.json, for: .accept)
        do {
            let bodyDict: [String: Any] = [
                "token": body.token,
                "address_id": body.addressID,
                "bonus": body.bonus,
                "products": Dictionary(uniqueKeysWithValues: body.products.map {
                    ($0.id, $0.count)
                })
            ]
            let bodyData = try JSONSerialization.data(withJSONObject: bodyDict)
            request.httpBody = bodyData
            return URLSession.shared.dataTaskPublisher(for: request)
                .validateResponse()
                .filter { $0.isEmpty }
                .map { _ in () }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: APIError.encodeError(error)).eraseToAnyPublisher()
        }
    }
}
