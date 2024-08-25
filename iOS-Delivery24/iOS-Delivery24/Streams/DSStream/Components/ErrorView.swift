//
// ErrorView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    var error: APIError

    var body: some View {
        ErrorView
    }
}

// MARK: - UI Subviews

private extension ErrorView {

    var ErrorView: some View {
        VStack(alignment: .leading, spacing: .SPx4) {
            switch error {
            case .invalidURL:
                ErrorTitle("Неверный URL")
            case .encodeError:
                ErrorTitle("Ошибка кодирования")
            case .invalidResponse:
                ErrorTitle("Ошибка ответа сервера")
            case .invalidData:
                ErrorTitle("Невалидные данные")
            case .decodingError(let error):
                ErrorTitle("Ошибка декодирования данных")
                ErrorText("\(error)")
            case .error(let error):
                ErrorTitle("Неизвестная ошибка")
                ErrorText("\(error)")
            }

            Spacer()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image(.gradientBG))
        .overlay(alignment: .bottom) {
            DLBasketMakeOrderButton(
                configuration: .init(
                    title: "Написать",
                    subtitle: "Сообщите об ошибке",
                    isDisable: false
                )
            )
            .padding()
        }
    }

    func ErrorText(_ string: String) -> some View {
        Text(string)
            .style(size: 11, weight: .regular, color: DLColor<TextPalette>.gray800.color)
    }

    func ErrorTitle(_ title: String) -> some View {
        Text(title)
            .style(size: 17, weight: .heavy, color: DLColor<TextPalette>.primary.color)
    }
}

// MARK: - Preview

#Preview {
    ErrorView(error: .invalidURL)
}
