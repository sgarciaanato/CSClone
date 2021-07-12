//
//  BranchPresenter+AislesCollectionView.swift
//  CSClone
//
//  Created by Samuel García on 7/12/21.
//

import UIKit

extension BranchPresenter {
    func configureAislesCollectionViewDataSource() {
        guard let mainView = _viewController?.mainView else { return }
        mainView.aislesCollectionView.collectionView.register(AisleCollectionViewCell.self, forCellWithReuseIdentifier: AisleCollectionViewCell.reuseIdentifier)
        mainView.aislesCollectionView.collectionView.register(AisleSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AisleSectionHeader.reuseIdentifier)
        aislesDataSource = UICollectionViewDiffableDataSource<Department, Aisle>(collectionView: mainView.aislesCollectionView.collectionView) { (collectionView, indexPath, aisle) -> UICollectionViewCell? in
            self.configureAisle(AisleCollectionViewCell.self, with: aisle, for: indexPath)
        }
        
        aislesDataSource?.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AisleSectionHeader.reuseIdentifier, for: indexPath) as? AisleSectionHeader else { return nil }

            guard let department = self?.branchDetailContainer?.departments[indexPath.section] else { return nil }
            if department.name.isEmpty { return nil }
            sectionHeader.configure(department: department, product: department.topProducts.first)
            if let viewController = self?.viewController {
                sectionHeader.delegate = viewController
            }
            
            return sectionHeader
        }
    }
    
    func configureAisle<T: SelfConfiguringAisleCell>(_ cellType: T.Type, with aisle: Aisle, for indexPath: IndexPath) -> T {
        guard let cell = _viewController?.mainView.aislesCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(aisle)
        return cell
    }
    
    func applyAislesSnapshot(department: Department) {
        var aislesSnapshot = aislesDataSource.snapshot()
        aislesSnapshot.appendSections([department])
        aislesDataSource.apply(aislesSnapshot)
    }
}
