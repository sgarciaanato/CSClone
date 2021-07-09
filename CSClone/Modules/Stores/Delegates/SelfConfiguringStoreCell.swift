//
//  SelfConfiguringStoreCell.swift
//  CSClone
//
//  Created by Samuel García on 6/30/21.
//

protocol SelfConfiguringStoreCell {
    static var reuseIdentifier: String { get }
    func configureWith(_ store: StoreItem)
}
