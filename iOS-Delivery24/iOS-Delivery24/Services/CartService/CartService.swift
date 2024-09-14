//
// CartService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 07.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Combine
import Foundation

protocol CartServiceProtocol {
    func addBasketProductPublisher(body: AddBasketProductBody) -> AnyPublisher<Void, APIError>
}

final class CartService: CartServiceProtocol {

    static let shared: CartServiceProtocol = CartService()
    private let router = Router.Cart.self

    private init() {}

    // MARK: - CREATE -

    func addBasketProductPublisher(body: AddBasketProductBody) -> AnyPublisher<Void, APIError> {
        guard let url = router.Paths.add.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        let body: [String: Any] = [
            "token": body.token,
            "address_id": body.addressID,
            "product_id": body.productID,
            "count": body.count
        ]
        return postVoidPubliser(url: url, body: body)
    }
}
