//
//  BranchPresenter+FeaturedCollectionView.swift
//  CSClone
//
//  Created by Samuel García on 7/12/21.
//

import UIKit

extension BranchPresenter {
    func configureFeaturedCollectionViewDataSource() {
        guard let mainView = _viewController?.mainView else { return }
        mainView.branchCollectionView.featuredDepartmentCollectionView.register(PromotionCollectionViewCell.self, forCellWithReuseIdentifier: PromotionCollectionViewCell.reuseIdentifier)
        featuredDataSource = UICollectionViewDiffableDataSource<String, BranchPromotion>(collectionView: mainView.branchCollectionView.featuredDepartmentCollectionView) { (collectionView, indexPath, promotion) -> UICollectionViewCell? in
            self.configurePromotion(PromotionCollectionViewCell.self, with: promotion, for: indexPath)
        }
    }
    
    func configurePromotion<T: SelfConfiguringPromotionCell>(_ cellType: T.Type, with protomotion: BranchPromotion?, for indexPath: IndexPath) -> T {
        guard let cell = _viewController?.mainView.branchCollectionView.featuredDepartmentCollectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(protomotion)
        return cell
    }
    
    func applyDepartmentSnapshot(departments: [Department]) {
        var snapshot = alternativeDataSource.snapshot()
        snapshot.appendSections(["department"])
        snapshot.appendItems(departments, toSection: "department")
        alternativeDataSource.apply(snapshot)
    }
}
