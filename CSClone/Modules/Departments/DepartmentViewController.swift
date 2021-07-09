//
//  DepartmentViewController.swift
//  CSClone
//
//  Created by Samuel García on 7/6/21.
//

import UIKit

class DepartmentViewController: UIViewController {
    
    var presenter: DepartmentPresenterDelegate?
    
    private var _mainView: DepartmentCollectionView?
    var mainView: DepartmentCollectionView! {
        get {
            if _mainView == nil {
                _mainView = DepartmentCollectionView()
                _mainView?.delegate = self
            }
            return _mainView
        }
    }
    
    override func loadView() {
        view = mainView
        view.backgroundColor = UIColor.systemGroupedBackground
    }
    
    func push() {
        guard let viewController = presenter?.productPresenter?.viewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension DepartmentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectItemAt(indexPath)
    }
}
