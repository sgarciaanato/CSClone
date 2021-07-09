//
//  Product.swift
//  CSClone
//
//  Created by Samuel García on 7/2/21.
//

struct Product: Codable, Hashable {
    let identifier: Int
    let brand: Brand
    let kind: String
    let relatedTo: String?
    let buyUnit: String
    let defaultBuyUnit: String
    let variableWeight: Bool?
    let currency: String
    let unitConversionRate: Float?
    let purchasable: Bool
    let pricing: Pricing
    let pricePerUnit: String
    let regulatoryFees: [String]
    let price: Float
    let originalPrice: String?
    let label: String?
    let descriptionSections: [DescriptionSections]
    let availabilityStatus: String?
    let nutritionalInfo: String?
    let name: String
    let description: String?
    let package: String
    let imgUrl: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case brand
        case kind
        case relatedTo = "related_to"
        case buyUnit = "buy_unit"
        case defaultBuyUnit = "default_buy_unit"
        case variableWeight = "variable_weight"
        case currency
        case unitConversionRate = "unit_conversion_rate"
        case purchasable
        case pricing
        case pricePerUnit = "price_per_unit"
        case regulatoryFees = "regulatory_fees"
        case price
        case originalPrice = "original_price"
        case label
        case descriptionSections = "description_sections"
        case availabilityStatus = "availability_status"
        case nutritionalInfo = "nutritional_info"
        case name
        case description
        case package
        case imgUrl = "img_url"
    }
}

struct DescriptionSections: Codable, Hashable {
    let title: String
    let text: String
    let type: String
}

