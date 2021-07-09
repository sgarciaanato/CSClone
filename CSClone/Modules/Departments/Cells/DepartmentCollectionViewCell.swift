//
//  DepartmentCollectionViewCell.swift
//  CSClone
//
//  Created by Samuel García on 7/9/21.
//

import UIKit

class DepartmentCollectionViewCell: UICollectionViewCell, SelfConfiguringDepartmentCell {
    static let reuseIdentifier: String = "DepartmentCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(_ department: Department) {
        debugPrint(department.name)
    }
}
