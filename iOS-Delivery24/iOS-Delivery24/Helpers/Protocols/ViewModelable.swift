//
// ViewModelable.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

/// Основной протокол для экранов
protocol ViewModelable: View {
    associatedtype ViewModel: ViewModelProtocol

    var viewModel: ViewModel { get }
}
