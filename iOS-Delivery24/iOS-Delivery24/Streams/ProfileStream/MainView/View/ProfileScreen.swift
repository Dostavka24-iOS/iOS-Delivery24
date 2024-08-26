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
    @StateObject private var nav = Navigation()

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            MainBlock
                .backport.navigationDestination(for: ProductEntity.self) { product in
                    let vm = ProductDetailsViewModel(
                        data: .init(product: product)
                    )
                    ProductDetailsView(viewModel: vm).navigationBarTitleDisplayMode(.inline)
                }
                .backport.navigationDestination(for: ViewModel.Rows.self) { row in
                    switch row {
                    case .userData:
                        MyDataScreen(viewModel: .init())
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
        }
        .onAppear {
            viewModel.setReducers(nav: nav)
        }
    }
}

// MARK: - Preview

#Preview("MockData") {
    ProfileScreen(viewModel: .mockData)
}

#Preview {
    ProfileScreen()
}
