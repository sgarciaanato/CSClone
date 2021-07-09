//
//  StoreListPresenterDelegate.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

import Foundation

protocol StoreListPresenterDelegate {
    func viewDidLoad()
    var branchPresenter: BranchPresenter? { get }
}
