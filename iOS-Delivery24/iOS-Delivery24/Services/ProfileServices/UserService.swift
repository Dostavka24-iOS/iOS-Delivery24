//
// UserService.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

protocol UserServiceProtocol {
    func getUserDataPublisher(token: String) -> AnyPublisher<UserEntity, APIError>
}

final class UserService: UserServiceProtocol {

    static let shared: UserServiceProtocol = UserService()
    private let router = Router.Profile.self

    private init() {}

    func getUserDataPublisher(token: String) -> AnyPublisher<UserEntity, APIError> {
        guard let url = router.User.user.urlPath.toURL else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        let body = ["token": token]
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = bodyData
            return URLSession.shared.dataTaskPublisher(for: request)
                .validateResponse()
                .decode()
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: APIError.error(error)).eraseToAnyPublisher()
        }
    }
}
