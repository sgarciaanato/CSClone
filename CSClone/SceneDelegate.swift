//
//  SceneDelegate.swift
//  CSClone
//
//  Created by Samuel García on 6/25/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let storePresenter = StoreListPresenter()
        let branchPresenter = BranchPresenter()
        let departmentPresenter = DepartmentPresenter()
        let productPresenter = ProductPresenter()
        branchPresenter.departmentPresenter = departmentPresenter
        branchPresenter.productPresenter = productPresenter
        departmentPresenter.productPresenter = productPresenter
        storePresenter.branchPresenter = branchPresenter
        let navigationController = UINavigationController(rootViewController: storePresenter.viewController)
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

