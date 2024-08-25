//
// ProductDetailsVM+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension ProductDetailsViewModel: Mockable {

    static let mockData = ProductDetailsViewModel(
        data: ProductDetailsVMData(
            product: .mockData
        )
    )
}

extension ProductEntity: Mockable {

    static let mockData = ProductEntity(
        id: 2570,
        sku: "85a532ff-7382-11eb-80d5-2c4d5451998e",
        title: "Напиток MacCoffee Original кофейный растворимый 3 в 1 100пак*20г",
        price: "1116.00",
        quantity: 1816,
        description: """
        Maccoffee 3в1 — это приготовленный из кофе высшего сорта, сахара и сливок растворимый кофейный напиток,который не только наполняет энергией, но и дарит богаство ощущений благодаря насыщенному вкусу, а также удобству употребления в любое время при любых обстоятельствах.
        """,
        image: "/import/import_files/85/85a532ff738211eb80d52c4d5451998e_36f5eb65ba3811eb80dc2c4d5451998e.png",
        categoryID: 69,
        priceSale: "0.00",
        cashback: "0.50",
        brandID: 359,
        manufacturerID: 0,
        createdAt: "2021-07-21 19:12:34",
        updatedAt: "2024-08-24 21:31:11",
        slug: "",
        actionFlag: 0,
        actionCountdown: nil,
        coeff: 100,
        ean: "8887290101028",
        hit: 1,
        actionFlag2: 1,
        exclusFlag: 0,
        rating: 225400,
        priceItem: "11.16",
        tags: nil,
        maxInOrder: 0,
        expirationDate: "730",
        kolvoUpak: 1,
        newYearFlag: 0,
        quantity2: 35,
        countryID: 0,
        brandTitle: "MacCoffee",
        whishlistFlag: false,
        brand: ProductEntity.Brand(
            id: 359,
            title: "MacCoffee",
            createdAt: "2021-08-11 09:12:09",
            updatedAt: "2021-08-11 09:12:09",
            mainFlag: 0
        )
    )
}
#endif
