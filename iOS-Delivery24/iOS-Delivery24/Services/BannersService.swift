//
// BannersService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 23.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol BannersServiceProtocol {
    func getBannersPublisher() -> AnyPublisher<[BannerEntity], APIError>
}

final class BannersService: BannersServiceProtocol {

    static let shared: BannersServiceProtocol = BannersService()
    private let router = Router.Banner.self

    private init() {}

    func getBannersPublisher() -> AnyPublisher<[BannerEntity], APIError> {
        guard let url = URL(string: router.banners) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard
                    let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode)
                else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: [BannerEntity].self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return APIError.decodingError(error)
                }
                return APIError.error(error)
            }
            .eraseToAnyPublisher()
    }
}
