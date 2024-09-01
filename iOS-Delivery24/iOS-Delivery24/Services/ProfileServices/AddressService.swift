//
// AddressService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 31.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol AddressServiceProtocol {
    func getAddressPublisher(token: String) -> AnyPublisher<[AddressEntity], APIError>
}

final class AddressService: AddressServiceProtocol {
    static let shared: AddressServiceProtocol = AddressService()
    private let router = Router.Order.self

    private init() {}

    func getAddressPublisher(token: String) -> AnyPublisher<[AddressEntity], APIError> {
        guard let url = router.Address.addresses.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(.json, for: .contentType)
        request.setValue(.json, for: .accept)
        let body = ["token": token]
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = bodyData
            return URLSession.shared.dataTaskPublisher(for: request)
                .validateResponse()
                .decode()
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: APIError.encodeError(error)).eraseToAnyPublisher()
        }
    }
}
