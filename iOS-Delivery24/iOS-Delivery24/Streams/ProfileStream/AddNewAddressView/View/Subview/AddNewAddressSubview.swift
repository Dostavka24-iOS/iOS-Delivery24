//
// AddNewAddressSubview.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension AddNewAddressView {

    var MainBlock: some View {
        ScrollView {
            VStack(spacing: 32) {
                CellView(
                    title: "Название магазина",
                    placeholder: "Название",
                    text: $viewModel.uiProperties.name
                )

                CellView(
                    title: "Полный адрес",
                    placeholder: "Сюда доставят ваш заказ ",
                    text: $viewModel.uiProperties.address
                )

                // FIXME: Тут должен быть пикер
                CellView(
                    title: "Город",
                    placeholder: "Выберите город",
                    text: $viewModel.uiProperties.city
                )

                CellView(
                    title: "Улица",
                    placeholder: "Название",
                    text: $viewModel.uiProperties.street
                )

                CellView(
                    title: "Дом",
                    placeholder: "Номер",
                    text: $viewModel.uiProperties.homeNumber
                )

                CellView(
                    title: "Квартира/Офис",
                    placeholder: "Номер",
                    text: $viewModel.uiProperties.apartamentNumber
                )
            }
            .padding(.horizontal)
        }
    }

    func CellView(
        title: String,
        placeholder: String,
        text: Binding<String>
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .style(size: 13, weight: .semibold, color: Constants.textColor)

            InputView(placeholder: placeholder, text: text)
        }
    }

    func InputView(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(DLColor<SeparatorPalette>.gray.color)
            }
    }
}

// MARK: - Preview

#Preview {
    AddNewAddressView()
}

// MARK: - Constants

private extension AddNewAddressView {

    enum Constants {
        static let textColor = DLColor<TextPalette>.primary.color
    }
}
