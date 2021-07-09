//
//  Department.swift
//  CSClone
//
//  Created by Samuel García on 7/2/21.
//

struct Department: Codable, Hashable {
    let identifier: String
    let imgUrl: String
    let name: String
    let topProducts: [Product]
    var aisles: [Aisle]
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        identifier = try container.decode(String.self, forKey: .identifier)
//        imgUrl = try container.decode(String.self, forKey: .imgUrl)
//        name = try container.decode(String.self, forKey: .name)
//        topProducts = try container.decode([Product].self, forKey: .topProducts)
//        var tempAisles = [Aisle(identifier: "", imgUrl: "", name: "All in \(name)", numProducts: nil, topProducts: nil, featured: nil, department: self)]
//        let aisles = try container.decode([Aisle].self, forKey: .aisles)
//        tempAisles.append(contentsOf: aisles)
//        self.aisles = aisles
//        super.init()
//    }
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case imgUrl = "img_url"
        case name
        case topProducts = "top_products"
        case aisles
    }
    
    mutating func appendHimslefAtFirst() {
        aisles.insert(Aisle(identifier: "", imgUrl: "", name: "All in \(name)", numProducts: nil, topProducts: nil, featured: nil, department: self), at: 0)
    }
}
