//
//  BranchPresenter.swift
//  CSClone
//
//  Created by Samuel García on 6/30/21.
//

import UIKit

class BranchPresenter {
    
    var departmentPresenter: DepartmentPresenter?
    var productPresenter: ProductPresenter?
    
    //Branch CollectionView
    var dataSource: UICollectionViewDiffableDataSource<Department, Product>!
    var featuredDataSource: UICollectionViewDiffableDataSource<String, BranchPromotion>!
    
    //Aisles CollectionView
    var aislesDataSource: UICollectionViewDiffableDataSource<Department, Aisle>!
    
    //Alternative Branch CollectionView
    var alternativeDataSource: UICollectionViewDiffableDataSource<String, Department>!
    var alternativePromotionDataSource: UICollectionViewDiffableDataSource<BranchPromotion, BranchPromotion>!
    
    var branch: Branch?
    let service = BranchService()
    var branchDetailContainer: BranchDetailContainer? {
        didSet {
            for (index, _) in (branchDetailContainer?.departments ?? []).enumerated() {
                branchDetailContainer?.departments[index].appendHimslefAtFirst()
            }
            viewController.mainView.branchCollectionView.branchDetailContainer = branchDetailContainer
            viewController.mainView.aislesCollectionView.branchDetailContainer = branchDetailContainer
            viewController.mainView.alternativeBranchCollectionView.branchDetailContainer = branchDetailContainer
        }
    }
    
    var _viewController: BranchViewController?
    var viewController: BranchViewController {
        if let viewController = _viewController {
            return viewController
        }
        let viewController = BranchViewController()
        viewController.presenter = self
        _viewController = viewController
        return viewController
    }
    
    var autoScrollPromotionsTimer: Timer?
    var autoScrollPromotionsIndex = 0
    
    func fetchBranch(_ branchIdentifier: String) {
        guard let branchDetailContainer = service.getBranchDetail(branchIdentifier) else { return }
        configureBranchCollectionViewDataSource()
        configureFeaturedCollectionViewDataSource()
        configureAislesCollectionViewDataSource()
        configureAlternativeCollectionViewDataSource()
        configureAlternativeFeaturedCollectionViewDataSource()
        self.branchDetailContainer = branchDetailContainer
        for department in self.branchDetailContainer?.departments ?? [] {
            applySnapshot(department: department)
            applyAislesSnapshot(department: department)
        }
        let promotions = self.branchDetailContainer?.branch.featured
        applyFeaturedSnapshot(promotions: promotions)
        applyAlternativeFeaturedSnapshot(promotions: promotions)
        applyDepartmentSnapshot(departments: branchDetailContainer.departments)
        autoScrollPromotionsTimer?.invalidate()
        autoScrollPromotionsIndex = 0
        autoScrollPromotionsTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(autoScrollPromotions), userInfo: nil, repeats: true)
    }
    
    @objc func autoScrollPromotions() {
        guard let featuredDepartmentCollectionView = _viewController?.mainView.branchCollectionView.featuredDepartmentCollectionView, let promotionsCount = branchDetailContainer?.branch.featured?.count else { return }
        if autoScrollPromotionsIndex < promotionsCount - 1 {
            autoScrollPromotionsIndex += 1
        } else {
            autoScrollPromotionsIndex = 0
        }
        featuredDepartmentCollectionView.scrollToItem(at: IndexPath(item: autoScrollPromotionsIndex, section: 0), at: .top, animated: true)
        if let alternativeCollectionView = _viewController?.mainView.alternativeBranchCollectionView.featuredDepartmentCollectionView {
            alternativeCollectionView.scrollToItem(at: IndexPath(item: 0, section: autoScrollPromotionsIndex), at: .top, animated: true)
        }
    }
    
    func configureWith(_ branch: Branch) {
        guard self.branch != branch else { return }
        self.branch = branch
        fetchBranch(branch.identifier)
    }
    
}

extension BranchPresenter: BranchPresenterDelegate {
    func selectProduct(product: Product, department: Department) {
        departmentPresenter?.configureWith(department, product: product)
        viewController.push()
    }
    
    func selectAisleDepartment(_ department: Department) {
        var aislesSnapshot = aislesDataSource.snapshot()
        guard let firstAisle = department.aisles.first else { return }
        if aislesSnapshot.sectionIdentifier(containingItem: firstAisle) != department {
            aislesSnapshot.appendItems(department.aisles, toSection: department)
        } else {
            aislesSnapshot.deleteItems(department.aisles)
        }
        aislesDataSource.apply(aislesSnapshot, animatingDifferences: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let mainView = _viewController?.mainView else { return }
        switch collectionView {
        case mainView.branchCollectionView.collectionView:
            guard let department = branchDetailContainer?.departments[indexPath.section] else { return }
            let product = department.topProducts[indexPath.row]
            departmentPresenter?.configureWith(department, product: product)
            viewController.push()
            break
        case mainView.branchCollectionView.featuredDepartmentCollectionView:
            guard let url = branchDetailContainer?.branch.featured?[indexPath.row].url else { return }
            debugPrint("Tap on promotion \(url)")
            break
        case mainView.aislesCollectionView.collectionView:
            if let department = branchDetailContainer?.departments[indexPath.section].aisles[indexPath.row].department {
                departmentPresenter?.configureWith(department, product: nil)
                viewController.push()
            }
            if let id = branchDetailContainer?.departments[indexPath.section].aisles[indexPath.row].identifier {
                debugPrint("Tap on aisle id \(id)")
            }
            break
        case mainView.alternativeBranchCollectionView.collectionView:
            guard let department = branchDetailContainer?.departments[indexPath.row] else { return }
            departmentPresenter?.configureWith(department, product: nil)
            viewController.push()
            break
        case mainView.alternativeBranchCollectionView.collectionView:
            guard let department = branchDetailContainer?.departments[indexPath.row] else { return }
            departmentPresenter?.configureWith(department, product: nil)
            viewController.push()
            break
        default: break
        }
    }
    
    func setPage(_ page: Int) {
        autoScrollPromotionsIndex = page
        autoScrollPromotionsTimer?.invalidate()
        autoScrollPromotionsTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(autoScrollPromotions), userInfo: nil, repeats: true)
    }
}
