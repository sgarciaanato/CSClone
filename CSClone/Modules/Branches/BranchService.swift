//
//  BranchService.swift
//  CSClone
//
//  Created by Samuel García on 7/2/21.
//

import Foundation

class BranchService {
    
    func getBranchDetail(_ branchIdentifier: String) -> BranchDetailContainer? {
        guard let storeListData = Mock.loadData("Branch-\(branchIdentifier)") else { return nil}
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(BranchDetailContainer.self, from: storeListData)
        } catch {
            debugPrint("getBranchDetail error:\(error)")
        }
        return nil
    }
    
}
