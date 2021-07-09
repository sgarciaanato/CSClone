//
//  SelfConfiguringDepartmentCell.swift
//  CSClone
//
//  Created by Samuel García on 7/9/21.
//

protocol SelfConfiguringDepartmentCell {
    static var reuseIdentifier: String { get }
    func configureWith(_ department: Department)
}
