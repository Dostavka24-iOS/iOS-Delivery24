//
// MakeOrderView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct MakeOrderView: View {
    typealias ViewModel = MakeOrderViewModel

    @StateObject var viewModel: ViewModel
    @EnvironmentObject private var nav: Navigation
    @EnvironmentObject private var mainVM: MainViewModel

    var body: some View {
        MainBlock.onAppear {
            viewModel.setReducers(nav: nav, mainVM: mainVM)
        }
        .fullScreenCover(isPresented: $viewModel.uiProperties.showSuccessView) {
            ThankYouView()
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        MakeOrderView(viewModel: .mockData)
    }
    .environmentObject(MainViewModel.mockData)
    .environmentObject(Navigation())
}
