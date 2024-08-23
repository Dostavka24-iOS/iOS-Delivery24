//
// PopcatsService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 23.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol PopcatsServiceProtocol {
    func getPopcatsPublisher() -> AnyPublisher<[PopcatsEntity], APIError>
}

final class PopcatsService: PopcatsServiceProtocol {

    static let shared: PopcatsServiceProtocol = PopcatsService()
    private let router = Router.Popcats.self

    private init() {}

    func getPopcatsPublisher() -> AnyPublisher<[PopcatsEntity], APIError> {
        guard let url = URL(string: router.popcats.urlPath) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .validateResponse()
            .decode()
    }
}
