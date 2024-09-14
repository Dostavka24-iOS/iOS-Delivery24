//
// ProductDetailsViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Combine
import Foundation

protocol ProductDetailsViewModelProtocol: ViewModelProtocol {
    // MARK: Values
    var uiProperties: ProductDetailsViewModel.UIProperties { get set }
    var data: ProductDetailsViewModel.ProductDetailsVMData { get }
    var makeBasketButtonTitle: String? { get }
    // MARK: Actions
    func didTapAddIntoBasketButton()
    func didTapLike()
    func didTapShare()
    // MARK: Networks
    func fetchData()
}

final class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    @Published var uiProperties: UIProperties
    @Published private(set) var data: ProductDetailsVMData

    init(
        data: ProductDetailsVMData,
        uiProperties: UIProperties = .init()
    ) {
        self.uiProperties = uiProperties
        self.data = data
    }
}

// MARK: - Networks

extension ProductDetailsViewModel {

    func fetchData() {}
}

// MARK: - Actions

extension ProductDetailsViewModel {

    func didTapAddIntoBasketButton() {
        print("[DEBUG]: \(#function)")
    }

    func didTapLike() {
        print("[DEBUG]: \(#function)")
    }

    func didTapShare() {
        print("[DEBUG]: \(#function)")
    }
}

// MARK: - Computed Values

extension ProductDetailsViewModel {

    var makeBasketButtonTitle: String? {
        guard
            let priceItemString = data.product.priceItem,
            let priceItemDouble = Double(priceItemString),
            let priceString = data.product.price,
            let priceDouble = Double(priceString)
        else {
            return nil
        }

        return "\(Int(priceDouble / priceItemDouble)) шт · \(priceDouble.toBeautifulPrice)"
    }

    var calculateDate: String? {
        guard let daysInt = Int(data.product.expirationDate ?? "") else {
            return nil
        }

        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = daysInt
        let calendar = Calendar.current
        if let futureDate = calendar.date(byAdding: dateComponent, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "ru_RU")
            let formattedDate = dateFormatter.string(from: futureDate)
            return "\(daysInt) дн. (до \(formattedDate))"
        }

        return "\(daysInt) дн."
    }
}
