//
//  ProductPresenter.swift
//  CSClone
//
//  Created by Samuel García on 7/6/21.
//

import UIKit

class ProductPresenter {
    var product: Product?
    private var _viewController: ProductViewController?
    var viewController: ProductViewController {
        if let viewController = _viewController {
            return viewController
        }
        let viewController = ProductViewController()
        _viewController = viewController
        return viewController
    }
    
    func configureWith(_ product: Product) {
        guard self.product != product else { return }
        self.product = product
        viewController.configureWith(product)
    }
    
}
