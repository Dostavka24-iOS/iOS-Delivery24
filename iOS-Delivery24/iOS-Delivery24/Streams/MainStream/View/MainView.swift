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

    @StateObject var viewModel = MainViewModel()

    var body: some View {
        MainBlock
    }
}

// MARK: - Actions

extension MainView {

    func didTapSectionLookMore() {
        print("[DEBUG]: Нажали")
    }
}

// MARK: - Preview

#Preview {
    MainView()
}
