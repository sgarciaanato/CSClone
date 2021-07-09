//
//  Brand.swift
//  CSClone
//
//  Created by Samuel García on 7/2/21.
//

struct Brand: Codable, Hashable {
    let identifier: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
}
