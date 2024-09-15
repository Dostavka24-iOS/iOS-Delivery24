//
// UserEntity.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct UserEntity: Decodable, EntityProtocol {
    let id: Int?
    let email: String?
    let emailVerifiedAt: String?
    let role: Int?
    let createdAt: String?
    let updatedAt: String?
    let phone: String?
    let name: String?
    let address: String?
    let inn: String?
    let kpp: String?
    let addressFact: String?
    let guid: String?
    let balance: String?
    let verifyFlagEmail: Int?
    let verifyFlagPhone: Int?
    let verifyCodeEmail: String?
    let verifyCodePhone: String?
    let cart: String?
    let ageLimitFlag: Int?
    let tgAuthCode: String?
    let tgID: Int?
    let minOrder: Int?
    let managerID: Int?
    let token: String?
    let currentAddressID: Int?
    let salesFlag: Int?
    let tgAuthCodeSales: Int?
    let tgIdSales: String?

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case emailVerifiedAt = "email_verified_at"
        case role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case phone
        case name
        case address
        case inn
        case kpp
        case addressFact = "address_fact"
        case guid
        case balance
        case verifyFlagEmail = "verify_flag_email"
        case verifyFlagPhone = "verify_flag_phone"
        case verifyCodeEmail = "verify_code_email"
        case verifyCodePhone = "verify_code_phone"
        case cart
        case ageLimitFlag = "age_limit_flag"
        case tgAuthCode = "tg_auth_code"
        case tgID = "tg_id"
        case minOrder = "min_order"
        case managerID = "manager_id"
        case token
        case currentAddressID = "current_address_id"
        case salesFlag = "sales_flag"
        case tgAuthCodeSales = "tg_auth_code_sales"
        case tgIdSales = "tg_id_sales"
    }
}

// MARK: - Mapper

extension UserEntity {

    var mapper: UserModel? {
        guard
            let id,
            let token,
            let email
        else {
            Logger.log(kind: .error, message: "Ошибка маппинга `UserEntity` с id=\(id ?? -1)")
            return nil
        }

        return UserModel(
            id: id,
            email: email,
            phone: phone ?? "",
            name: name ?? "",
            inn: inn ?? "",
            kpp: kpp ?? "",
            token: token
        )
    }
}
