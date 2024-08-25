//
// CategoryService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol CategoryServiceProtocol {
    func getCategoryPublisher(token: String) -> AnyPublisher<[CategoryEntity], APIError>
}

final class CategoryService: CategoryServiceProtocol {

    static let shared: CategoryServiceProtocol = CategoryService()
    private let router = Router.Catalog.Categories.self

    private init() {}

    func getCategoryPublisher(token: String) -> AnyPublisher<[CategoryEntity], APIError> {
        guard let url = router.categories.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
//        let bodyDict = ["token": token]
//        do {
//            let bodyData = try JSONSerialization.data(withJSONObject: bodyDict, options: [])
//            var request = URLRequest(url: URL(string: "https://www.dostavka24.net/api/catalog/categories")!)
//            request.httpMethod = HTTPMethod.get.rawValue
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//            request.addValue("gzip, deflate", forHTTPHeaderField: "Accept-Encoding")
//            request.httpBody = bodyData

            return URLSession.shared.dataTaskPublisher(for: url)
                .validateResponse()
                .decode()
//        } catch {
//            return Fail(error: APIError.encodeError(error)).eraseToAnyPublisher()
//        }
    }
}
