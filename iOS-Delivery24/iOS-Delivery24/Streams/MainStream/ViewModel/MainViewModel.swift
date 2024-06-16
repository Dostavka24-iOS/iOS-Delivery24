//
// MainViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

protocol MainViewModelProtocol: ViewModelProtocol {
    // MARK: Actions
    func didTapSectionLookMore(section: MainViewModel.Section)
    func didTapSearchProduct()
    func didTapWallet()
    func didTapSelectAddress()
    func didTapLookPopularSection()
}

final class MainViewModel: MainViewModelProtocol {
    @Published var sections: [Section]
    @Published var uiProperties: UIProperties

    init(
        sections: [Section] = [],
        uiProperties: UIProperties = UIProperties()
    ) {
        self.sections = sections
        self.uiProperties = uiProperties
    }
}

// MARK: - Actions

extension MainViewModel {

    func didTapSectionLookMore(section: Section) {
        print("[DEBUG]: Нажали: \(section.title)")
    }

    func didTapSearchProduct() {
        print(uiProperties.searchText)
    }

    func didTapWallet() {
        print("[DEBUG]: Нажали кошелёк")
    }

    func didTapSelectAddress() {
        print("[DEBUG]: Нажали выбрать адрес")
    }

    func didTapLookPopularSection() {
        print("[DEBUG]: Нажали секцию популярных категорий")
    }
}
