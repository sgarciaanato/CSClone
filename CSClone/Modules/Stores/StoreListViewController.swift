//
//  StoreListViewController.swift
//  CSClone
//
//  Created by Samuel García on 6/25/21.
//

import UIKit

class StoreListViewController: UIViewController {
    
    var presenter: StoreListPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    var mainView: StoreListCollectionView!
    
    override func loadView() {
        if mainView == nil {
            mainView = StoreListCollectionView()
            mainView.delegate = self
        }
        view = mainView
        view.backgroundColor = UIColor.systemGroupedBackground
    }
    
}

extension StoreListViewController: StoreListCollectionViewDelegate {
    func selectBranch(_ branch: Branch) {
        guard let viewController = presenter?.branchPresenter?.viewController else { return }
        presenter?.branchPresenter?.configureWith(branch)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
