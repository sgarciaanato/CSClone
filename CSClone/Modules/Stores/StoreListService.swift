//
//  StoreListService.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

import Foundation

class StoreListService {
    
    func getStores() -> [StoreContainer]? {
        guard let storeListData = Mock.loadData("StoreList") else { return nil}
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode([StoreContainer].self, from: storeListData)
        } catch {
            debugPrint("getStores error:\(error)")
        }
        return nil
    }
    
}
