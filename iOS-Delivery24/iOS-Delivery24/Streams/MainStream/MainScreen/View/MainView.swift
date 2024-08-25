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
            Image(.gradientBG)
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

struct ErrorView: View {
    var error: APIError

    var body: some View {
        ErrorView
    }

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
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image(.gradientBG))
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
