//
//  Aisle.swift
//  CSClone
//
//  Created by Samuel García on 7/2/21.
//

struct Aisle: Codable, Hashable {
    let identifier: String
    let imgUrl: String
    let name: String
    let numProducts: Int?
    let topProducts: [Product]?
    
    var featured: [BranchPromotion]?
    var department: Department?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case imgUrl = "img_url"
        case name
        case numProducts = "num_products"
        case topProducts = "top_products"
        case department = "department"
    }
}
