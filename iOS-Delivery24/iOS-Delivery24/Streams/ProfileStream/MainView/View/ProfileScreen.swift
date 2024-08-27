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
                .backport.navigationDestination(for: ProductEntity.self) { product in
                    productScreen(for: product)
                }
                .backport.navigationDestination(for: ViewModel.Rows.self) { row in
                    nextScreenView(row: row)
                }
        }
        .environmentObject(nav)
        .onAppear {
            viewModel.setReducers(nav: nav, userModel: mainVM.data.userModel)
        }
    }
}

// MARK: - Navigation Destination

private extension ProfileScreen {

    @ViewBuilder
    func nextScreenView(row: ProfileScreen.ViewModel.Rows) -> some View {
        switch row {
        case .userData:
            if let userModel = viewModel.data.userModel {
                MyDataScreen(
                    viewModel: .init(
                        userModel: userModel
                    )
                )
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
    func productScreen(for product: ProductEntity) -> some View {
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
