//
//  BranchPresenter+AlternativeFeaturedCollectionView.swift
//  CSClone
//
//  Created by Samuel García on 7/12/21.
//

import UIKit

extension BranchPresenter {
    func configureAlternativeFeaturedCollectionViewDataSource() {
        guard let mainView = _viewController?.mainView else { return }
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
    
    func applyAlternativeFeaturedSnapshot(promotions: [BranchPromotion]?) {
        guard let promotions = promotions else { return }
        var snapshot = alternativePromotionDataSource.snapshot()
        snapshot.appendSections(promotions)
        for promotion in promotions {
            snapshot.appendItems([promotion], toSection: promotion)
        }
        alternativePromotionDataSource.apply(snapshot)
    }
}

