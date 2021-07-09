//
//  BranchDetailContainer.swift
//  CSClone
//
//  Created by Samuel García on 7/2/21.
//

struct BranchDetailContainer: Codable, Hashable {
    var branch: Branch
    var departments: [Department]
}
