//
//  BranchPromotion.swift
//  CSClone
//
//  Created by Samuel García on 7/2/21.
//

struct BranchPromotion: Codable, Hashable {
    let identifier: String
    let imageSet: ImageSet?
    let caption: String
    let backgroundColor: String
    let isLight: Bool
    let url: String
    let validUntil: String
    let priority: Int
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case imageSet = "imageset"
        case caption
        case backgroundColor = "background_color"
        case isLight = "is_light"
        case url
        case validUntil = "valid_until"
        case priority
    }
}
