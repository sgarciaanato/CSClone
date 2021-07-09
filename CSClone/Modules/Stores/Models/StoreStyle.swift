//
//  StoreStyle.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

struct StoreStyle: Codable, Hashable {
    let type: String
    let attributes: StoreStyleAttributes
}

struct StoreStyleAttributes: Codable, Hashable {
    let preferredOrientation: String?
    let preferredSize: String?
    
    enum CodingKeys: String, CodingKey {
        case preferredOrientation = "preferred_orientation"
        case preferredSize = "preferred_size"
    }
}
