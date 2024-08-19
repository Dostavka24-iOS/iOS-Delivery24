//
// PickAddresView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct PickAddressView: View, ViewModelable {
    typealias ViewModel = PickAddresViewModel
    @StateObject var viewModel = ViewModel()

    var body: some View {
        MainBlock
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        PickAddressView()
    }
}
