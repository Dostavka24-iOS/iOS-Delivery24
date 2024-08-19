//
// MakeOrderViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol MakeOrderViewModelProtocol: ViewModelProtocol {
    // MARK: Actions
    func didTapApplyBonuses()
    func didTapMakeOrder()
}

final class MakeOrderViewModel: MakeOrderViewModelProtocol {
    @Published var resultData: ResultData
    @Published var uiProperties: UIProperies

    init(
        resultData: ResultData,
        uiProperties: UIProperies = .init()
    ) {
        self.uiProperties = uiProperties
        self.resultData = resultData
    }

    var bonusesIncluded: Bool {
        uiProperties.bonusesIncluded
    }

    var deliveryTitle: String {
        resultData.deliveryPrice == 0 ? "Бесплатно" : String(resultData.deliveryPrice)
    }
}

// MARK: - Actions

extension MakeOrderViewModel {
    
    /// Нажали `применить` бонусы
    func didTapApplyBonuses() {
        // Число должно быть кратным 100
        guard let number = Int(uiProperties.bonusesCount), number % 100 == 0 else { return }
        resultData.bonusesCount = Int(uiProperties.bonusesCount)
    }
    
    /// Нажали `Оформить заказ`
    func didTapMakeOrder() {
        resultData.bonusesCount = bonusesIncluded ? resultData.bonusesCount : 0
        print("[DEBUG]: Нажали оформить заказ")
        print("[DEBUG]: bonusesIncluded=\(uiProperties.bonusesIncluded) | \(resultData.bonusesCount ?? 0) | resultSum=\(resultData.resultSum)")
    }
}
