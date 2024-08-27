//
// URLSession+Extensions.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import Combine

extension URLSession.DataTaskPublisher {

    func validateResponse() -> AnyPublisher<Data, APIError> {
        tryMap { data, response in
            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                throw APIError.invalidResponse
            }
            return data
        }
        .mapError { error in
            if error is DecodingError {
                return APIError.decodingError(error)
            }
            return APIError.error(error)
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher where Failure == APIError, Output == Data {

    func decode<T: Decodable>() -> AnyPublisher<T, APIError> {
        decode(type: T.self, decoder: JSONDecoder())
        .mapError { error in
            if error is DecodingError {
                return APIError.decodingError(error)
            }
            return APIError.error(error)
        }
        .eraseToAnyPublisher()
    }
}
