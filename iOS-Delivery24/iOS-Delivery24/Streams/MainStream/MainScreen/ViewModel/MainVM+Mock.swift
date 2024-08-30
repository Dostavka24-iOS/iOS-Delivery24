//
// MainVM+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension MainViewModel: Mockable {

    static let mockData: MainViewModel = MainViewModel(
        data: .init(
            userModel: .mockData,
            sections: .mockData,
            banners: [
                .init(
                    id: 0,
                    title: nil,
                    image: URL?.fakeURL?.absoluteString,
                    link: nil,
                    sortOrder: nil,
                    text: nil,
                    createdAt: nil,
                    updatedAt: nil,
                    type: nil
                )
            ],
            basketProducts: [1: 20, 3: 23]
        ),
        uiProperties: UIProperties(screenState: .default)
    )
}

extension [MainViewModel.Section]: Mockable {

    static let mockData: [MainViewModel.Section] = [
        .actions(stocksData.map(\.mapperToEntity)),
        .exclusives(exclusivesData.map(\.mapperToEntity)),
        .hits(hitsData.map(\.mapperToEntity)),
        .news((0...20).map { .mockData(id: $0) })
    ]

    static let fakeEntityProducts: [ProductEntity] = [MainViewModel.Section].mockData.last?.products ?? []

    private static let stocksData: [MainViewModel.Product] = (1...10).map {
        .init(
            id: $0,
            imageURL: URL?.mockURL?.absoluteString ?? "",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            startCounter: 12,
            magnifier: 12,
            tags: [.promotion]
        )
    }
    private static let exclusivesData: [MainViewModel.Product] = (11...20).map {
        .init(
            id: $0,
            imageURL: "https://w.forfun.com/fetch/1c/1c0cb4d2eb25fc8b9dbc607f1a00999c.jpeg",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            startCounter: 0,
            magnifier: 1,
            tags: [.exclusive]
        )
    }
    private static let hitsData: [MainViewModel.Product] = (21...30).map {
        .init(
            id: $0,
            imageURL: "https://i.pinimg.com/originals/0a/11/5c/0a115c7cc29faac76456247ae095d771.jpg",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            startCounter: 0,
            magnifier: 1,
            tags: [.hit]
        )
    }
    static let newsData: [MainViewModel.Product] = (31...40).map {
        .init(
            id: $0,
            imageURL: "/import/import_files/4e/4efb83e35bd811ef8d5f005056845ec0_4efb83f05bd811ef8d5f005056845ec0.png",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            startCounter: 23,
            magnifier: 23,
            tags: [.news]
        )
    }
}

private extension MainViewModel.Product {

    var mapperToEntity: ProductEntity {
        .init(
            id: id,
            sku: nil,
            title: title,
            price: nil,
            quantity: nil,
            description: description,
            image: imageURL,
            categoryID: nil,
            priceSale: nil,
            cashback: nil,
            brandID: nil,
            manufacturerID: nil,
            createdAt: nil,
            updatedAt: nil,
            slug: nil,
            actionFlag: nil,
            actionCountdown: nil,
            coeff: startCounter,
            ean: nil,
            hit: tags.contains(.hit) ? 1 : 0,
            actionFlag2: tags.contains(.promotion) ? 1 : 0,
            exclusFlag: tags.contains(.promotion) ? 1 : 0,
            rating: nil,
            priceItem: price,
            tags: nil,
            maxInOrder: nil,
            expirationDate: nil,
            kolvoUpak: nil,
            newYearFlag: nil,
            quantity2: nil,
            countryID: nil,
            brandTitle: nil,
            whishlistFlag: nil,
            brand: .init(id: nil, title: nil, createdAt: nil, updatedAt: nil, mainFlag: nil)
        )
    }
}

extension ProductEntity: Mockable {

    static func mockData(id: Int) -> ProductEntity {
        ProductEntity(
            id: id,
            sku: "85a532ff-7382-11eb-80d5-2c4d5451998e",
            title: "Напиток MacCoffee Original кофейный растворимый 3 в 1 100пак*20г",
            price: "1116.00",
            quantity: 1816,
            description: "Maccoffee 3в1 — это приготовленный из кофе высшего сорта, сахара и сливок растворимый кофейный напиток,который не только наполняет энергией, но и дарит богаство ощущений благодаря насыщенному вкусу, а также удобству употребления в любое время при любых обстоятельствах.",
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

    static var mockData: ProductEntity {
        ProductEntity(
            id: 10,
            sku: "85a532ff-7382-11eb-80d5-2c4d5451998e",
            title: "Напиток MacCoffee Original кофейный растворимый 3 в 1 100пак*20г",
            price: "1116.00",
            quantity: 1816,
            description: "Maccoffee 3в1 — это приготовленный из кофе высшего сорта, сахара и сливок растворимый кофейный напиток,который не только наполняет энергией, но и дарит богаство ощущений благодаря насыщенному вкусу, а также удобству употребления в любое время при любых обстоятельствах.",
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
}

extension UserEntity: Mockable {

    static let mockData = UserEntity(
        id: 1941,
        email: "dimapermyakov55@gmail.com",
        emailVerifiedAt: nil,
        role: 1,
        createdAt: "2024-08-24 16:57:47",
        updatedAt: "2024-08-24 18:23:18",
        phone: "+7(916)855-99-42",
        name: "migthyK1ngRichard",
        address: "г Москва, метро Улица 1905 года",
        inn: "502750627801",
        kpp: "123456789",
        addressFact: "г Москва, метро Улица 1905 года",
        guid: nil,
        balance: "500.00",
        verifyFlagEmail: 1,
        verifyFlagPhone: 0,
        verifyCodeEmail: "DKWQvgFd3xYCysoZbhtrtiAgnTg9WGTw",
        verifyCodePhone: nil,
        cart: "N;",
        ageLimitFlag: 1,
        tgAuthCode: "xSVhHdniGL7qnjeL",
        tgID: nil,
        minOrder: 0,
        managerID: 0,
        token: "wFbiEwN3fRrujnou",
        currentAddressID: 0,
        salesFlag: 0,
        tgAuthCodeSales: nil,
        tgIdSales: nil
    )
}

#endif
