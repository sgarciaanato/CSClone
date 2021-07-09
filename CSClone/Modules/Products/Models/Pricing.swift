//
//  Pricing.swift
//  CSClone
//
//  Created by Samuel García on 7/2/21.
//

struct Pricing: Codable, Hashable {
    let originalPrice: Price?
    let price: Price
    let pricePerUnit: Price?
    
    enum CodingKeys: String, CodingKey {
        case originalPrice = "original_price"
        case price
        case pricePerUnit = "price_per_unit"
    }
}

struct Price: Codable, Hashable {
    let label: String?
    let unit: String?
    let amount: Float
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case label
        case unit
        case amount
        case currency
    }
}
