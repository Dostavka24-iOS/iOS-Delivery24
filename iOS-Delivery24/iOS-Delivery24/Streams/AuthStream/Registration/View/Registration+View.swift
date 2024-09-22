//
//  Registration+View.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 22.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import SwiftUI

struct RegistrationView: ViewModelable {
    @StateObject var viewModel = RegistrationViewModel()
    @EnvironmentObject private var nav: Navigation
    @EnvironmentObject private var mainVM: MainViewModel

    var body: some View {
        mainContainer.onAppear {
//            viewModel.setReducers(nav: nav, mainVM: mainVM)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        RegistrationView()
    }
    .environmentObject(Navigation())
    .environmentObject(MainViewModel.mockData)
}
