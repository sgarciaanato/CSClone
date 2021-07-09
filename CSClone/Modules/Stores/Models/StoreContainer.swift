//
//  StoreContainer.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

struct StoreContainer: Codable, Hashable {
    let identifier: String
    let name: String
    let items: [StoreItem]
    let style: StoreStyle
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        name = try container.decode(String.self, forKey: .name)
        var items = try container.decode([StoreItem].self, forKey: .items)
        for (index,item) in items.enumerated() {
            items[index].type = "\(item.type)-\(identifier)"
        }
        self.items = items
        style = try container.decode(StoreStyle.self, forKey: .style)
    }
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case items
        case style
    }
}
