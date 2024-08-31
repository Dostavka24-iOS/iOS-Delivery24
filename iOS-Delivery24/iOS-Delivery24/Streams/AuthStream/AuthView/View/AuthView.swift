//
// AuthView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()
    @EnvironmentObject private var nav: Navigation
    @EnvironmentObject private var mainVM: MainViewModel

    var body: some View {
        MainContainer.onAppear {
            viewModel.setupReducers(nav: nav, mainVM: mainVM)
        }
    }
}

// MARK: - Preview

#Preview {
    AuthView()
        .environmentObject(Navigation())
        .environmentObject(MainViewModel())
}
