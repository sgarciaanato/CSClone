//
//  BranchPresenterDelegate.swift
//  CSClone
//
//  Created by Samuel García on 6/30/21.
//

import UIKit

protocol BranchPresenterDelegate {
    var departmentPresenter: DepartmentPresenter? { get }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func selectAisleDepartment(_ department: Department)
    func setPage(_ page: Int)
}
