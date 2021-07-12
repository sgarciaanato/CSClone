//
//  BranchPresenter+AlternativeBranchCollectionView.swift
//  CSClone
//
//  Created by Samuel García on 7/12/21.
//

import UIKit

extension BranchPresenter {
    func configureAlternativeCollectionViewDataSource() {
        guard let mainView = _viewController?.mainView else { return }
        mainView.alternativeBranchCollectionView.collectionView.register(DepartmentCollectionViewCell.self, forCellWithReuseIdentifier: DepartmentCollectionViewCell.reuseIdentifier)
        alternativeDataSource = UICollectionViewDiffableDataSource<String, Department>(collectionView: mainView.alternativeBranchCollectionView.collectionView, cellProvider: { (collectionView, indexPath, department) -> UICollectionViewCell? in
            let cell = self.configureDepartment(DepartmentCollectionViewCell.self, with: department, for: indexPath)
            cell.delegate = self
            return cell
        })
        
        mainView.alternativeBranchCollectionView.featuredDepartmentCollectionView.register(BranchPromotionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BranchPromotionSectionHeader.reuseIdentifier)
        mainView.alternativeBranchCollectionView.featuredDepartmentCollectionView.register(PromotionCollectionViewCell.self, forCellWithReuseIdentifier: PromotionCollectionViewCell.reuseIdentifier)
        alternativePromotionDataSource = UICollectionViewDiffableDataSource<BranchPromotion, BranchPromotion>(collectionView: mainView.alternativeBranchCollectionView.featuredDepartmentCollectionView) { (collectionView, indexPath, promotion) -> UICollectionViewCell? in
            //remove unnecesary code
            self.configurePromotion(PromotionCollectionViewCell.self, with: nil, for: indexPath)
        }
        
        alternativePromotionDataSource?.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BranchPromotionSectionHeader.reuseIdentifier, for: indexPath) as? BranchPromotionSectionHeader else { return nil }
            
            guard let promotion = self?.branchDetailContainer?.branch.featured?[indexPath.section] else { return nil }
            sectionHeader.configure(promotion: promotion)
            
            return sectionHeader
        }
    }
    
    func configureDepartment<T: SelfConfiguringDepartmentCell>(_ cellType: T.Type, with department: Department, for indexPath: IndexPath) -> T {
        guard let cell = _viewController?.mainView.alternativeBranchCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(department)
        return cell
    }
    
    func applyFeaturedSnapshot(promotions: [BranchPromotion]?) {
        guard let promotions = promotions else { return }
        var snapshot = featuredDataSource.snapshot()
        snapshot.appendSections(["promotion"])
        snapshot.appendItems(promotions, toSection: "promotion")
        featuredDataSource.apply(snapshot)
    }
}
