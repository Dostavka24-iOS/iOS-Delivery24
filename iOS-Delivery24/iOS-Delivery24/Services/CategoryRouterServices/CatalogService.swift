//
// CatalogService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol CategoryServiceProtocol {
    func getCategoryProductsPubliser(token: String?, categoryID: String) -> AnyPublisher<[CategoryProductEntity], APIError>
    func getCategoryPublisher(token: String?) -> AnyPublisher<[CategoryEntity], APIError>
}

final class CatalogService: CategoryServiceProtocol {

    static let shared: CategoryServiceProtocol = CatalogService()
    private let router = Router.Catalog.Paths.self

    private init() {}

    func getCategoryProductsPubliser(token: String?, categoryID: String) -> AnyPublisher<[CategoryProductEntity], APIError> {
        guard let url = router.products.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        let bodyDict = [
            "token": token,
            "category_id": categoryID
        ]

        do {
            let bodyData = try JSONSerialization.data(withJSONObject: bodyDict)
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.httpBody = bodyData
            request.setValue(.json, for: .contentType)
            request.setValue(.json, for: .accept)

            return URLSession.shared.dataTaskPublisher(for: request)
                .validateResponse()
                .decode()
        } catch {
            return Fail(error: APIError.encodeError(error)).eraseToAnyPublisher()
        }
    }

    func getCategoryPublisher(token: String?) -> AnyPublisher<[CategoryEntity], APIError> {
        guard let url = router.categories.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        guard let token else {
            return URLSession.shared.dataTaskPublisher(for: url)
                .validateResponse()
                .decode()
        }

        let bodyDict = ["token": token]
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: bodyDict)
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue(.json, for: .contentType)
            request.setValue(.json, for: .accept)
            request.httpBody = bodyData

            return URLSession.shared.dataTaskPublisher(for: url)
                .validateResponse()
                .decode()
        } catch {
            return Fail(error: APIError.encodeError(error)).eraseToAnyPublisher()
        }
    }
}
