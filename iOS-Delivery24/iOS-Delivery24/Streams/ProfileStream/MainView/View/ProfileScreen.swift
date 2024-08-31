//
// ProfileScreen.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import NavigationStackBackport

struct ProfileScreen: View {
    typealias ViewModel = ProfileViewModel
    
    @StateObject var viewModel = ViewModel()
    @EnvironmentObject var mainVM: MainViewModel
    @StateObject private var nav = Navigation()

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            MainBlock
                .onAppear {
                    viewModel.onAppearAndsetReducers(nav: nav, mainVM: mainVM)
                }
                .backport.navigationDestination(for: ViewModel.Screens.self) { screen in
                    openNextScreen(for: screen)
                }
        }
        .environmentObject(nav)
    }
}

// MARK: - Navigation Destination

private extension ProfileScreen {

    @ViewBuilder
    func openNextScreen(for screen: ViewModel.Screens) -> some View {
        switch screen {
        case .auth:
            AuthView()
        case .registration:
            Text("Регистрация в разработке")
        case let .product(product):
            openProductScreen(for: product)
        case let .row(row):
            openRowScreenView(row: row)
        }
    }

    @ViewBuilder
    func openRowScreenView(row: ProfileScreen.ViewModel.Rows) -> some View {
        switch row {
        case .userData:
            if let userModel = viewModel.data.userModel {
                MyDataScreen(
                    viewModel: .init(
                        userModel: userModel
                    )
                )
            } else {
                ErrorView(error: .customErrorText(Constants.errorText))
            }
        case .favorites:
            Text("favorites")
        case .address:
            Text("address")
        case .orders:
            Text("Text")
        case .faq:
            Text("faq")
        case .telegramBot:
            Text("telegramBot")
        case .info:
            Text("info")
        case .feedback:
            Text("feedback")
        case .quit:
            Text("quit")
        }
    }

    @ViewBuilder
    func openProductScreen(for product: ProductEntity) -> some View {
        let vm = ProductDetailsViewModel(
            data: .init(product: product)
        )
        ProductDetailsView(viewModel: vm)
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview("MockData") {
    ProfileScreen(viewModel: .mockData)
        .environmentObject(Navigation())
        .environmentObject(MainViewModel.mockData)
}

#Preview {
    ProfileScreen()
        .environmentObject(Navigation())
        .environmentObject(MainViewModel())
}

// MARK: - Constants

private extension ProfileScreen {

    enum Constants {
        static let errorText = "Получен неверный формат данных о пользователе. Не обнаружена информация о логине или токене пользоветеля. Вероятно, случилась ошибка на стороне сервера"
    }
}
