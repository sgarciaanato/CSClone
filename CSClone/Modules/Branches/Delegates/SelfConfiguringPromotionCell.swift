//
//  SelfConfiguringPromotionCell.swift
//  CSClone
//
//  Created by Samuel García on 7/6/21.
//

protocol SelfConfiguringPromotionCell {
    static var reuseIdentifier: String { get }
    func configureWith(_ promotion: BranchPromotion?)
}
