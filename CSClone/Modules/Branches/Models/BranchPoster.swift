//
//  BranchPoster.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

struct BranchPoster: Codable, Hashable {
    let imageSet: ImageSet
    
    enum CodingKeys: String, CodingKey {
        case imageSet = "imageset"
    }
}

struct ImageSet: Codable, Hashable {
    let x1: String?
    let x2: String?
    let x3: String?
    
    enum CodingKeys: String, CodingKey {
        case x1 = "1x"
        case x2 = "2x"
        case x3 = "3x"
    }
}
