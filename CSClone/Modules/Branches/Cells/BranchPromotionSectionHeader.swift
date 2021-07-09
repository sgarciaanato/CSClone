//
//  BranchPromotionSectionHeader.swift
//  CSClone
//
//  Created by Samuel García on 7/9/21.
//

import UIKit

class BranchPromotionSectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "BranchPromotionSectionHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configure(promotion: BranchPromotion) {
        debugPrint("Promotion \(promotion.caption)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
