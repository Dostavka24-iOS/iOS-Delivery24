//
// ProfileScreen.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct ProfileScreen: View {
    typealias ViewModel = ProfileViewModel
    @StateObject var viewModel = ViewModel()

    var body: some View {
        MainBlock
    }
}

// MARK: - Preview

#Preview {
    ProfileScreen()
}
