//
//  StoreItem.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

struct StoreItem: Codable, Hashable {
    var type: String
    let badges: [String]
    let content: Branch
}
