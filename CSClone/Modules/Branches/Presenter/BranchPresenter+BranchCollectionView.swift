//
//  BranchPresenter+BranchCollectionView.swift
//  CSClone
//
//  Created by Samuel García on 7/12/21.
//

import UIKit

extension BranchPresenter {
    func configureBranchCollectionViewDataSource() {
        guard let mainView = _viewController?.mainView else { return }
        mainView.branchCollectionView.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        mainView.branchCollectionView.collectionView.register(BranchSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BranchSectionHeader.reuseIdentifier)
        dataSource = UICollectionViewDiffableDataSource<Department, Product>(collectionView: mainView.branchCollectionView.collectionView) { (collectionView, indexPath, product) -> UICollectionViewCell? in
            self.configure(ProductCollectionViewCell.self, with: product, for: indexPath)
        }
        
        dataSource?.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BranchSectionHeader.reuseIdentifier, for: indexPath) as? BranchSectionHeader else { return nil }
            
            guard let department = self?.branchDetailContainer?.departments[indexPath.section] else { return nil }
            if department.name.isEmpty { return nil }
            sectionHeader.configure(department: department)
            if let viewController = self?.viewController {
                sectionHeader.delegate = viewController
            }
            
            return sectionHeader
        }
    }
    
    func configure<T: SelfConfiguringProductCell>(_ cellType: T.Type, with product: Product, for indexPath: IndexPath) -> T {
        guard let cell = _viewController?.mainView.branchCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(product)
        return cell
    }
    
    func applySnapshot(department: Department) {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([department])
        snapshot.appendItems(department.topProducts, toSection: department)
        dataSource.apply(snapshot)
    }
}
