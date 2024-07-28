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

    var body: some View {
        MainBlock
    }
}

// MARK: - Preview

//#Preview {
//    NavigationView {
//        MakeOrderView()
//    }
//}
