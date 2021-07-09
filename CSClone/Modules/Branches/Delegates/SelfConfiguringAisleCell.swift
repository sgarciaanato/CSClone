//
//  SelfConfiguringAisleCell.swift
//  CSClone
//
//  Created by Samuel García on 7/7/21.
//

protocol SelfConfiguringAisleCell {
    static var reuseIdentifier: String { get }
    func configureWith(_ aisle: Aisle)
}
