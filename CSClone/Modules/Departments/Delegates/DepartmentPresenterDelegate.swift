//
//  DepartmentPresenterDelegate.swift
//  CSClone
//
//  Created by Samuel García on 7/6/21.
//

import Foundation

protocol DepartmentPresenterDelegate {
    var productPresenter: ProductPresenter? { get }
    func selectItemAt(_ indexPath: IndexPath)
}
