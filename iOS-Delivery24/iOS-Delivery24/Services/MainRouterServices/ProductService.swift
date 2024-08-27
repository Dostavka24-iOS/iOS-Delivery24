//
// ProductService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 23.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol ProductServiceProtocol {
    func getActionsProductsPublisher() -> AnyPublisher<[ProductEntity], APIError>
    func getExclusivesProductPublisher() -> AnyPublisher<[ProductEntity], APIError>
    func getHitsProductPublisher() -> AnyPublisher<[ProductEntity], APIError>
    func getNewsProductPublisher() -> AnyPublisher<[ProductEntity], APIError>
}

final class ProductService: ProductServiceProtocol {

    static let shared: ProductServiceProtocol = ProductService()
    private let router = Router.Main.Product.self

    private init() {}

    func getActionsProductsPublisher() -> AnyPublisher<[ProductEntity], APIError> {
        guard let url = URL(string: router.actions.urlPath) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return basicProductPublisher(url: url)
    }

    func getExclusivesProductPublisher() -> AnyPublisher<[ProductEntity], APIError> {
        guard let url = URL(string: router.exclusives.urlPath) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return basicProductPublisher(url: url)
    }

    func getHitsProductPublisher() -> AnyPublisher<[ProductEntity], APIError> {
        guard let url = URL(string: router.hits.urlPath) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return basicProductPublisher(url: url)
    }

    func getNewsProductPublisher() -> AnyPublisher<[ProductEntity], APIError> {
        guard let url = URL(string: router.news.urlPath) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return basicProductPublisher(url: url)
    }
}

// MARK: - Helper

private extension ProductService {

    func basicProductPublisher(url: URL) -> AnyPublisher<[ProductEntity], APIError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .validateResponse()
            .decode()
    }
}
