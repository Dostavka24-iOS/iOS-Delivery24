//
// UserService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Combine
import Foundation

protocol UserServiceProtocol {
    func getUserDataPublisher(token: String) -> AnyPublisher<UserEntity, APIError>
    func getOrdersPublisher(token: String, orderID: Int) -> AnyPublisher<OrderDetailEntity, APIError>
    func getOrdersPublisher(token: String) -> AnyPublisher<[OrderEntity], APIError>
    func getProductBasket(token: String, addressID: Int) -> AnyPublisher<[ProductEntity], APIError>
}

final class UserService: UserServiceProtocol {

    static let shared: UserServiceProtocol = UserService()
    private let router = Router.Profile.self

    private init() {}

    // MARK: - GET -

    func getUserDataPublisher(token: String) -> AnyPublisher<UserEntity, APIError> {
        guard let url = router.Paths.user.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        return postPublisher(url: url, body: ["token": token])
    }

    func getOrdersPublisher(token: String, orderID: Int) -> AnyPublisher<OrderDetailEntity, APIError> {
        guard let url = router.Paths.order.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        let body: [String: Any] = [
            "token": token,
            "order_id": orderID
        ]
        return postPublisher(url: url, body: body)
    }

    func getOrdersPublisher(token: String) -> AnyPublisher<[OrderEntity], APIError> {
        guard let url = router.Paths.orders.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        return postPublisher(url: url, body: ["token": token])
    }

    func getProductBasket(token: String, addressID: Int) -> AnyPublisher<[ProductEntity], APIError> {
        guard let url = router.Paths.cart.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        let body: [String: Any] = [
            "token": token,
            "address_id": addressID
        ]
        return postPublisher(url: url, body: body)
    }
}
