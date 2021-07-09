//
//  Branch.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

struct Branch: Codable, Hashable {
    var identifier: String
    let name: String
    let excerpt: String?
    let storeId: String
    let pricingNotes: PricingNote
    let imgUrl: String?
    let brandColor: String?
    let poster: BranchPoster?
    
    var featured: [BranchPromotion]?
    
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let stringIdentifier = try container.decode(String.self, forKey: .identifier)
//        let intIdentifier = try container.decodeIfPresent(Int.self, forKey: .identifier)
//        identifier = "\(intIdentifier)" ?? stringIdentifier
//        name = try container.decode(String.self, forKey: .name)
//        excerpt = try container.decodeIfPresent(String.self, forKey: .excerpt)
//        storeId = try container.decode(String.self, forKey: .storeId)
//        pricingNotes = try container.decode(PricingNote.self, forKey: .pricingNotes)
//        imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl)
//        brandColor = try container.decodeIfPresent(String.self, forKey: .brandColor)
//        poster = try container.decodeIfPresent(BranchPoster.self, forKey: .poster)
//        featured = try container.decodeIfPresent([BranchPromotion].self, forKey: .featured)
//    }
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case excerpt
        case storeId = "store_id"
        case pricingNotes = "pricing_notes"
        case imgUrl = "img_url"
        case brandColor = "brand_color"
        case poster
        case featured
    }
}
