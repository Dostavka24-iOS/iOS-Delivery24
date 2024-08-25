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
        }
    }
}

// MARK: - Preview

#Preview {
    ProfileScreen()
}
