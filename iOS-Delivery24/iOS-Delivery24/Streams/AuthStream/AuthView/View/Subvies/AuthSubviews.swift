//
// AuthSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension AuthView {

    var MainContainer: some View {
        VStack(alignment: .leading, spacing: 0) {
            InputFieldsContainer
            RememberMeButton
            SignInButton
            DontRememberButton
        }
        .padding(.horizontal)
        .padding(.top, 67)
        .navigationTitle("Вход в аккаунт")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Image(.gradientBG)
                .resizable()
                .ignoresSafeArea()
        }
    }

    var SignInButton: some View {
        DLButton(
            configuration: .init(
                hasDisabled: viewModel.hasDisabledSignInButton,
                titleView: {
                    Text("Войти")
                        .style(size: 16, weight: .semibold, color: DLColor<TextPalette>.white.color)
                }),
            action: viewModel.didTapSignInButton
        )
        .padding(.top, 26)
    }

    var DontRememberButton: some View {
        Button(action: viewModel.didTapDontRememberButton, label: {
            Text("Не помню пароль")
                .style(size: 14, weight: .regular, color: Constants.textDarkBlue)
        })
        .frame(maxWidth: .infinity)
        .padding(.top, 32)
    }

    var RememberMeButton: some View {
        Button {
            viewModel.didTapRememberMeButton()
        } label: {
            HStack(spacing: .SPx1) {
                RememberMeIcon
                Text("Запонить меня")
                    .style(size: 13, weight: .regular, color: Constants.textPrimary)
            }
        }
        .padding(.top)
    }

    var InputFieldsContainer: some View {
        VStack(spacing: .SPx6) {
            EmaiInputView
            PasswordInputContainer
        }
    }

    var EmaiInputView: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            TitleView(title: "Адрес электронной почты")
            InputView(placeholder: "joedoe@gmail.com", text: $viewModel.uiProperties.userName)
        }
    }

    var PasswordInputContainer: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            TitleView(title: "Пароль")
            PasswordInputView
        }
    }

    var PasswordInputView: some View {
        HStack(spacing: .SPx2) {
            PasswordInputField
                .frame(height: 22)
            Button(action: viewModel.didTapVisibility, label: {
                VisibilityIcon.frame(width: 20, height: 20)
            })
        }
        .padding(12)
        .overlay {
            FieldOverlay
        }
    }

    @ViewBuilder
    var RememberMeIcon: some View {
        if viewModel.uiProperties.hasRememberMe {
            Image(.checkboxOn)
                .frame(width: 16, height: 16)
        } else {
            Image(.checkboxOff)
                .frame(width: 16, height: 16)
        }
    }

    @ViewBuilder
    var VisibilityIcon: some View {
        if viewModel.uiProperties.hasHiddenInput {
            Image(.visibilityOff)
        } else {
            Image(.visibilityOn)
        }
    }

    @ViewBuilder
    var PasswordInputField: some View {
        let placeholder = Text("******").style(
            size: 17,
            weight: .regular,
            color: Constants.textPlaceholder
        )

        if viewModel.uiProperties.hasHiddenInput {
            SecureField(text: $viewModel.uiProperties.password) {
                placeholder
            }
            .font(.system(size: 17, weight: .regular))
        } else {
            TextField(text: $viewModel.uiProperties.password) {
                placeholder
            }
            .font(.system(size: 17, weight: .regular))
        }
    }

    var FieldOverlay: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(lineWidth: 1)
            .fill(Constants.strokeColor)
    }

    func InputView(placeholder: String, text: Binding<String>) -> some View {
        TextField(text: text) {
            Text(placeholder)
                .style(size: 17, weight: .regular, color: Constants.textPlaceholder)
        }
        .padding(12)
        .overlay {
            FieldOverlay
        }
    }

    func TitleView(title: String) -> some View {
        Text(title)
            .style(size: 13, weight: .semibold, color: Constants.textPrimary)
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        AuthView()
    }
    .environmentObject(Navigation())
    .environmentObject(MainViewModel())
}

// MARK: - Constants

fileprivate extension AuthView {

    enum Constants {
        static let textDarkBlue = DLColor<TextPalette>.darkBlue.color
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textPlaceholder = DLColor<TextPalette>.placeholder.color
        static let strokeColor = DLColor<SeparatorPalette>.gray.color
    }
}

// MARK: - Draft

/*
 LinearGradient(
     colors: [
         DLColor<BackgroundPalette>(hexLight: 0xFFFFFF, hexDark: 0xFFFFFF).color,
         DLColor<BackgroundPalette>(hexLight: 0xB1F1FF, hexDark: 0xB1F1FF).color
     ],
     startPoint: .leading,
     endPoint: .trailing
 )
 .frame(height: 655)
 .offset(x: 200)
 .ignoresSafeArea()
*/
