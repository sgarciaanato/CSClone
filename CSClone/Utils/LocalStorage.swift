//
//  LocalStorage.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

import Foundation

final class LocalStorage {
    static let shared = LocalStorage()
    private let userDefault = UserDefaults.standard
    
    func store(_ key: String, data: Any) {
        userDefault.set(data, forKey: key)
    }
    
    func getData<T>(_ string: String) -> T? {
        guard let object =  userDefault.object(forKey: string) as? T else { return nil }
        return object
    }
    
    var premium: Bool {
        let premium: Bool? = getData("premium")
        return premium == true
    }
}
