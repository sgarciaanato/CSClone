//
//  SelfConfiguringProductCell.swift
//  CSClone
//
//  Created by Samuel García on 7/5/21.
//

protocol SelfConfiguringProductCell {
    static var reuseIdentifier: String { get }
    func configureWith(_ product: Product)
}
