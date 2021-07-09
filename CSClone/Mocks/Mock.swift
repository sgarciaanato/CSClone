//
//  Mock.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

import Foundation

class Mock {
    static func loadData(_ fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return try Data(contentsOf: url)
            } catch {
                debugPrint("loadData error:\(error)")
            }
        }
        return nil
    }
}
