//
// MyDataSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension MyDataScreen {

    var MainBlock: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                MainInfoBlock
                UserDataSection
                    .padding(.bottom, 100)
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constants.navigationTitle)
        .overlay(alignment: .bottom) {
            SaveButton
        }
    }

    func SectionTitle(_ title: String) -> some View {
        Text(title)
            .style(size: 22, weight: .bold, color: Constants.primaryColor)
            .padding(.bottom, 8)
            .padding(.top)
    }

    var MainInfoBlock: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionTitle("Основная информация ")

            VStack(spacing: 16) {
                EmailBlock

                PhoneBlock
            }
        }
    }

    var EmailBlock: some View {
        VStack(spacing: 24) {
            EmailHeaderView
            EmailFooterView
        }
        .padding([.horizontal, .top])
        .padding(.bottom, 24)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .fill(DLColor<SeparatorPalette>.orange.color)
        }
    }

    var EmailHeaderView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.emailTitle)
                .style(size: 13, weight: .semibold, color: Constants.primaryColor)

            TextField(text: $viewModel.uiProperties.emailInput) {
                Text("Enter the email")
            }
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Constants.seaparatorColor)
            }

            Button {

            } label: {
                Text("Запросить код")
                    .style(size: 13, weight: .regular, color: Constants.blueTextColor)
            }
        }
    }

    var EmailFooterView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                TextField(text: $viewModel.uiProperties.confirmationEmailСodeInput) {
                    Text("******")
                }
                .padding(.leading, 12)

                Button {
                    viewModel.didTapConfirmEmailCode()
                } label: {
                    Text("Подтвердить")
                        .style(size: 13, weight: .medium, color: Constants.secondaryColor)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 10)
                }
                .disabled(!viewModel.codeForEmailDidEntered)
                .background(
                    viewModel.codeForEmailDidEntered 
                    ? Constants.primaryBgColor
                    : Constants.secondaryBgColor
                )
            }
            .clipShape(.rect(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Constants.seaparatorColor)
            }

            Text("Введите код, полученный при регистрации, или перейдите поссылке из письма")
                .style(size: 13, weight: .regular, color: Constants.gray800Color)
                .padding(.top, 8)
        }
    }

    var PhoneBlock: some View {
        VStack(alignment: .leading, spacing: 23) {
            PhoneHeaderView
            PhoneFooterView
        }
        .padding([.horizontal, .top])
        .padding(.bottom, 24)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .fill(Constants.seaparatorGreenColor)
        }
    }

    var PhoneHeaderView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Телефон")
                .style(size: 13, weight: .semibold, color: Constants.primaryColor)

            TextField(text: $viewModel.uiProperties.phoneInput) {
                Text("+7")
            }
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Constants.seaparatorColor)
            }

            HStack {
                Button {
                    viewModel.didTapGetCall()
                } label: {
                    Text("Получить звонок")
                        .style(size: 13, weight: .regular, color: Constants.blueTextColor)
                }

                Spacer()

                Button {
                    viewModel.didTapGetCodeForPhone()
                } label: {
                    Text("Запросить код")
                        .style(size: 13, weight: .regular, color: Constants.blueTextColor)
                }
            }
        }
    }

    var PhoneFooterView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                TextField(text: $viewModel.uiProperties.confirmationPhoneСodeInput) {
                    Text("******")
                }
                .padding(.horizontal, 12)

                Button {
                    viewModel.didTapConfirmPhoneCode()
                } label: {
                    Text("Подтвердить")
                        .style(size: 13, weight: .medium, color: Constants.secondaryColor)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 10)
                }
                .disabled(!viewModel.codeForPhoneDidEntered)
                .background(
                    viewModel.codeForPhoneDidEntered
                    ? Constants.primaryBgColor
                    : Constants.secondaryBgColor
                )
            }
            .clipShape(.rect(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Constants.seaparatorColor)
            }

            Text("На номер телефона +7(906)714-73-10 поступит звонок. Для подтверждения телефона введите последние 4 цифры входящего номера телефона")
                .style(size: 13, weight: .regular, color: Constants.gray800Color)
        }
    }

    var UserDataSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionTitle("Ваши данные")
            UserDataRows
        }
    }

    var UserDataRows: some View {
        VStack(alignment: .leading, spacing: 24) {
            UserDataRow(
                title: "Наименование организации",
                inputText: $viewModel.uiProperties.companyName,
                placeholder: "Имя"
            )
            UserDataRow(
                title: "Инн",
                inputText: $viewModel.uiProperties.inn,
                placeholder: "707313761063"
            )
            UserDataRow(
                title: "КПП",
                inputText: $viewModel.uiProperties.kpp,
                placeholder: "272-04-042-4"
            )

        }
    }

    func UserDataRow(
        title: String,
        inputText: Binding<String>,
        placeholder: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .style(size: 13, weight: .semibold, color: Constants.primaryColor)

            HStack(spacing: 8) {
                TextField(placeholder, text: inputText)

                Image(.bottomChevron)
                    .frame(width: 20, height: 20)
            }
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Constants.separatorGrayColor)
            }
        }
    }

    var SaveButton: some View {
        Button {
            viewModel.didTapSave()
        } label: {
            Text("Сохранить")
                .style(size: 16, weight: .semibold, color: Constants.whiteTextColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 22)
        }
        .background(Constants.primaryBgColor, in: .rect(cornerRadius: 12))
        .padding(16)
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        MyDataScreen(viewModel: .init(userModel: .mockData))
    }
}

// MARK: - Constants

private extension MyDataScreen {

    enum Constants {
        static let navigationTitle = String(localized: "Мои данные")
        static let emailTitle = String(localized: "E-mail")
        static let whiteTextColor = DLColor<TextPalette>.white.color
        static let primaryColor = DLColor<TextPalette>.primary.color
        static let secondaryColor = DLColor<TextPalette>.gray300.color
        static let secondaryBgColor = DLColor<BackgroundPalette>.gray300.color
        static let primaryBgColor = DLColor<BackgroundPalette>.blue.color
        static let gray800Color = DLColor<TextPalette>.gray800.color
        static let blueTextColor = DLColor<TextPalette>.blue.color
        static let separatorGrayColor = DLColor<SeparatorPalette>.gray.color
        static let seaparatorColor = DLColor<SeparatorPalette>.gray300.color
        static let seaparatorGreenColor = DLColor<SeparatorPalette>.green.color
    }
}
