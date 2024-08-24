//
// MainView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct MainView: ViewModelable {
    typealias ViewModel = MainViewModel
    typealias Section = ViewModel.Section
    typealias Product = ViewModel.Product

    @StateObject var viewModel = ViewModel()

    var body: some View {
        iOS_View
            .preferredColorScheme(.light)
            .viewSize(size: $viewModel.uiProperties.size)
            .onSubmit(of: .search, viewModel.didTapSearchProduct)
            .onAppear(perform: viewModel.fetchData)
    }

    @ViewBuilder
    private var iOS_View: some View {
        switch viewModel.uiProperties.screenState {
        case .alert(let error):
            ErrorView(error: error)
        case .default:
            NavigationView {
                MainBlock
            }
        case .loading, .initial:
            LoadingView
        }
    }
}

// MARK: - UI Subviews

private extension MainView {

    var LoadingView: some View {
        ZStack {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 240)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DLColor<BackgroundPalette>.lightGray.color)
        .overlay(alignment: .bottom) {
            ProgressView()
                .offset(y: -50)
        }
    }

    func ErrorView(error: APIError) -> some View {
        VStack {
            switch error {
            case .invalidURL:
                Text("Неверный URL")
            case .encodeError:
                Text("Ошибка кодирования")
            case .invalidResponse:
                Text("Ошибка ответа сервера")
            case .invalidData:
                Text("Невалидные данные")
            case .decodingError(let error):
                Text("Ошибка декодирования данных")
                Text("\(error)")
            case .error(let error):
                Text("Неизвестная ошибка")
                Text("\(error)")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preview

#Preview("Сеть") {
    MainView()
}

#Preview {
    MainView(viewModel: .mockData)
}

// MARK: - Helper

private extension View {

    func viewSize(size: Binding<CGSize>) -> some View {
        background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        size.wrappedValue = proxy.size
                    }
            }
        }
    }
}

// MARK: - Constants

private extension MainView {

    enum Constants {
        static let searchText = String(localized: "search").capitalized
    }
}
