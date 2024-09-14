//
// PickAddressView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import NavigationStackBackport
import SwiftUI

struct PickAddressView: View, ViewModelable {
    typealias ViewModel = PickAddresViewModel

    @StateObject var viewModel: ViewModel
    @EnvironmentObject private var nav: Navigation

    var body: some View {
        MainBlock
            .backport.navigationDestination(for: ViewModel.Screens.self) { screen in
                openNextScreen(for: screen)
            }
            .onAppear {
                viewModel.setReducers(nav: nav)
                viewModel.fetch()
            }
    }
}

// MARK: - Navigation Destinations

private extension PickAddressView {

    @ViewBuilder
    func openNextScreen(for screen: ViewModel.Screens) -> some View {
        switch screen {
        case .addAddress:
            AddNewAddressView(viewModel: .init())
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        PickAddressView(viewModel: .mockData)
    }
    .environmentObject(Navigation())
}
