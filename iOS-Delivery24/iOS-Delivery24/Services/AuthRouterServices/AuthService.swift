//
// AuthService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 30.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol AuthServiceProtocol {
    func getAuthPublisher(email: String, password: String) -> AnyPublisher<AuthEntity, APIError>
}

final class AuthService: AuthServiceProtocol {

    static let shared: AuthServiceProtocol = AuthService()
    private let router = Router.Auth.self

    private init() {}

    func getAuthPublisher(email: String, password: String) -> AnyPublisher<AuthEntity, APIError> {
        guard let url = router.Auth.auth.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(.json, for: .contentType)
        request.setValue(.json, for: .accept)
        let body = [
            "email": email,
            "password": password
        ]
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
