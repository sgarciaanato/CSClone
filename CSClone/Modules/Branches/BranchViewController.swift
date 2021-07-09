//
//  BranchViewController.swift
//  CSClone
//
//  Created by Samuel García on 6/30/21.
//

import UIKit

class BranchViewController: UIViewController {
    
    var presenter: BranchPresenterDelegate?
    
    private var _mainView: BranchViewControllerContainer?
    var mainView: BranchViewControllerContainer! {
        get {
            if _mainView == nil {
                _mainView = BranchViewControllerContainer()
                _mainView?.branchCollectionView.delegate = self
                _mainView?.aislesCollectionView.delegate = self
            }
            return _mainView
        }
    }
    
    override func loadView() {
        view = mainView
        view.backgroundColor = UIColor.systemGroupedBackground
    }
    
    func push() {
        guard let viewController = presenter?.departmentPresenter?.viewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension BranchViewController: BranchDepartmentDelegate {
    func selectDepartment(_ department: Department?) {
        guard let viewController = presenter?.departmentPresenter?.viewController, let department = department else { return }
        presenter?.departmentPresenter?.configureWith(department)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension BranchViewController: AisleDepartmentDelegate {
    func selectAisleDepartment(_ department: Department?) {
        guard let department = department else { return }
        presenter?.selectAisleDepartment(department)
    }
}

extension BranchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}