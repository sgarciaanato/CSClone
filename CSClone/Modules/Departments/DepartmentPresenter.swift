//
//  DepartmentPresenter.swift
//  CSClone
//
//  Created by Samuel García on 7/6/21.
//

import UIKit

class DepartmentPresenter {
    
    var productPresenter: ProductPresenter?
    
    private var dataSource: UICollectionViewDiffableDataSource<Aisle, Product>!
    let service = DepartmentService()
    var department: Department? {
        didSet {
            viewController.mainView.department = department
        }
    }
    private var _viewController: DepartmentViewController?
    var viewController: DepartmentViewController {
        if let viewController = _viewController {
            return viewController
        }
        let viewController = DepartmentViewController()
        viewController.presenter = self
        _viewController = viewController
        return viewController
    }
    
    func configureDataSource() {
        guard let mainView = _viewController?.mainView else { return }
        mainView.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        mainView.collectionView.register(DepartmentSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DepartmentSectionHeader.reuseIdentifier)
        dataSource = UICollectionViewDiffableDataSource<Aisle, Product>(collectionView: mainView.collectionView) { (collectionView, indexPath, product) -> UICollectionViewCell? in
            self.configure(ProductCollectionViewCell.self, with: product, for: indexPath)
        }
        
        dataSource?.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DepartmentSectionHeader.reuseIdentifier, for: indexPath) as? DepartmentSectionHeader else { return nil }
            
            guard let aisle = self?.department?.aisles[indexPath.section] else { return nil }
            if aisle.name.isEmpty { return nil }
            sectionHeader.configure(aisle: aisle)
            
            return sectionHeader
        }
    }
    
    func configure<T: SelfConfiguringProductCell>(_ cellType: T.Type, with product: Product, for indexPath: IndexPath) -> T {
        guard let cell = _viewController?.mainView.collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(product)
        return cell
    }
    
    func fetchDepartment(_ departmentIdentifier: String) {
        guard let department = service.getDepartmentDetail(departmentIdentifier) else { return }
        configureDataSource()
        self.department = department
        for aisle in self.department?.aisles ?? [] {
            applySnapshot(department.identifier, aisle: aisle)
        }
    }
    
    func applySnapshot(_ type: String, aisle: Aisle) {
        guard let topProducts = aisle.topProducts else { return }
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([aisle])
        snapshot.appendItems(topProducts, toSection: aisle)
        dataSource.apply(snapshot)
    }
    
    func configureWith(_ department: Department, product: Product? = nil) {
        guard self.department != department else { return }
        self.department = department
        fetchDepartment(department.identifier)
        if let product = product {
            DispatchQueue.main.async {
                self.productPresenter?.configureWith(product)
                self.viewController.push()
            }
        }
    }
    
}

extension DepartmentPresenter: DepartmentPresenterDelegate {
    func selectItemAt(_ indexPath: IndexPath) {
        guard let product = department?.aisles[indexPath.section].topProducts?[indexPath.row] else {
            debugPrint("Nanai")
            return
        }
        productPresenter?.configureWith(product)
        viewController.push()
    }
}
