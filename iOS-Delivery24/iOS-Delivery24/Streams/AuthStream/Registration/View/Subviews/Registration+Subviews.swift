//
//  Registration+Subviews.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 22.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import SwiftUI

extension RegistrationView {

    var mainContainer: some View {
        VStack(alignment: .leading, spacing: 67) {
            headerContainer
            inputCodeContainer
            getPasswordButton
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle(Constants.navigationTitle)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                closeButton
            }
        }
    }
}

private extension RegistrationView {

    var headerContainer: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            Text(infoAttributedString)
                .style(size: 17, weight: .regular, color: Constants.textPrimary)
            Text(Constants.stepInfo)
                .style(size: 13, weight: .regular, color: Constants.textSecondary)
        }
    }

    var inputCodeContainer: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            Text(Constants.addressTitle)
                .style(size: 13, weight: .semibold, color: Constants.textPrimary)
            DLInputCode(
                placeholder: Constants.placeholder,
                text: $viewModel.uiProperties.inputEmail
            )
        }
    }

    var getPasswordButton: some View {
        DLButton(
            configuration: .init(hasDisabled: viewModel.getPasswordButtonIsDisable) {
                Text(Constants.getPasswordTitle)
                    .style(size: 16, weight: .semibold, color: Constants.textWhite)
            },
            action: viewModel.didTapGetPassword
        )
    }

    var closeButton: some View {
        Button(action: viewModel.didTapCloseScreen, label: {
            Image(.close)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        })
    }

    var infoAttributedString: AttributedString {
        var attributedText = AttributedString(Constants.info)
        if let range = attributedText.range(of: "ваш электронный адрес") {
            attributedText[range].font = .system(
                size: 17,
                weight: .bold
            )
        }
        return attributedText
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        RegistrationView()
    }
    .environmentObject(Navigation())
    .environmentObject(MainViewModel.mockData)
}

// MARK: - Constants

private extension RegistrationView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textSecondary = DLColor<TextPalette>.gray800.color
        static let textWhite = DLColor<TextPalette>.white.color

        static let info = """
        Мы вышлем пароль на ваш электронный адрес. Не забудьте проверить папку «Spam»
        """
        static let stepInfo = "Шаг 1 из 4"
        static let addressTitle = "Адрес электронной почты"
        static let navigationTitle = "Регистрация"
        static let placeholder = "joedoe@gmail.com"
        static let getPasswordTitle = "Получить пароль"
    }
}
