//
// MainViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

protocol MainViewModelProtocol: ViewModelProtocol {
}

final class MainViewModel: ObservableObject {
    @Published var sections: [Section]

    init(sections: [Section] = []) {
        self.sections = sections
    }
}

extension MainViewModel: MainViewModelProtocol {
}
