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
    
    private var dataSource: UICollectionViewDiffableDataSource<Department, Product>!
    private var aislesDataSource: UICollectionViewDiffableDataSource<Department, Aisle>!
    private var featuredDataSource: UICollectionViewDiffableDataSource<String, BranchPromotion>!
    
    private var alternativeDataSource: UICollectionViewDiffableDataSource<String, Department>!
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
    private var _viewController: BranchViewController?
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
    
    func configureDataSource() {
        guard let mainView = _viewController?.mainView else { return }
        mainView.branchCollectionView.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        mainView.branchCollectionView.collectionView.register(BranchSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BranchSectionHeader.reuseIdentifier)
        dataSource = UICollectionViewDiffableDataSource<Department, Product>(collectionView: mainView.branchCollectionView.collectionView) { (collectionView, indexPath, product) -> UICollectionViewCell? in
            self.configure(ProductCollectionViewCell.self, with: product, for: indexPath)
        }
        mainView.branchCollectionView.featuredDepartmentCollectionView.register(PromotionCollectionViewCell.self, forCellWithReuseIdentifier: PromotionCollectionViewCell.reuseIdentifier)
        featuredDataSource = UICollectionViewDiffableDataSource<String, BranchPromotion>(collectionView: mainView.branchCollectionView.featuredDepartmentCollectionView) { (collectionView, indexPath, promotion) -> UICollectionViewCell? in
            self.configurePromotion(PromotionCollectionViewCell.self, with: promotion, for: indexPath)
        }
        
        mainView.aislesCollectionView.collectionView.register(AisleCollectionViewCell.self, forCellWithReuseIdentifier: AisleCollectionViewCell.reuseIdentifier)
        mainView.aislesCollectionView.collectionView.register(AisleSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AisleSectionHeader.reuseIdentifier)
        aislesDataSource = UICollectionViewDiffableDataSource<Department, Aisle>(collectionView: mainView.aislesCollectionView.collectionView) { (collectionView, indexPath, aisle) -> UICollectionViewCell? in
            self.configureAisle(AisleCollectionViewCell.self, with: aisle, for: indexPath)
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
    
    func configureAlternativeDataSource() {
        guard let mainView = _viewController?.mainView else { return }
        mainView.alternativeBranchCollectionView.collectionView.register(DepartmentCollectionViewCell.self, forCellWithReuseIdentifier: DepartmentCollectionViewCell.reuseIdentifier)
        alternativeDataSource = UICollectionViewDiffableDataSource<String, Department>(collectionView: mainView.alternativeBranchCollectionView.collectionView, cellProvider: { (collectionView, indexPath, department) -> UICollectionViewCell? in
            self.configureDepartment(DepartmentCollectionViewCell.self, with: department, for: indexPath)
        })
    }
    
    func configure<T: SelfConfiguringProductCell>(_ cellType: T.Type, with product: Product, for indexPath: IndexPath) -> T {
        guard let cell = _viewController?.mainView.branchCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(product)
        return cell
    }
    
    func configurePromotion<T: SelfConfiguringPromotionCell>(_ cellType: T.Type, with protomotion: BranchPromotion, for indexPath: IndexPath) -> T {
        guard let cell = _viewController?.mainView.branchCollectionView.featuredDepartmentCollectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(protomotion)
        return cell
    }
    
    func configureAisle<T: SelfConfiguringAisleCell>(_ cellType: T.Type, with aisle: Aisle, for indexPath: IndexPath) -> T {
        guard let cell = _viewController?.mainView.aislesCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(aisle)
        return cell
    }
    
    func configureDepartment<T: SelfConfiguringDepartmentCell>(_ cellType: T.Type, with department: Department, for indexPath: IndexPath) -> T {
        guard let cell = _viewController?.mainView.alternativeBranchCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(department)
        return cell
    }
    
    func fetchBranch(_ branchIdentifier: String) {
        guard let branchDetailContainer = service.getBranchDetail(branchIdentifier) else { return }
        configureDataSource()
        configureAlternativeDataSource()
        self.branchDetailContainer = branchDetailContainer
        for department in self.branchDetailContainer?.departments ?? [] {
            applySnapshot(department: department)
            applyAislesSnapshot(department: department)
        }
        let promotions = self.branchDetailContainer?.branch.featured
        applyFeaturedSnapshot(promotions: promotions)
        autoScrollPromotionsTimer?.invalidate()
        autoScrollPromotionsIndex = 0
        autoScrollPromotionsTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(autoScrollPromotions), userInfo: nil, repeats: true)
        guard let departments = self.branchDetailContainer?.departments else { return }
        applyDepartmentSnapshot(departments: departments)
    }
    
    @objc func autoScrollPromotions() {
        guard let featuredDepartmentCollectionView = _viewController?.mainView.branchCollectionView.featuredDepartmentCollectionView, let promotionsCount = branchDetailContainer?.branch.featured?.count else { return }
        if autoScrollPromotionsIndex < promotionsCount - 1 {
            autoScrollPromotionsIndex += 1
        } else {
            autoScrollPromotionsIndex = 0
        }
        featuredDepartmentCollectionView.scrollToItem(at: IndexPath(item: autoScrollPromotionsIndex, section: 0), at: .top, animated: true)
    }
    
    func applySnapshot(department: Department) {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([department])
        snapshot.appendItems(department.topProducts, toSection: department)
        dataSource.apply(snapshot)
    }
    
    func applyAislesSnapshot(department: Department) {
        var aislesSnapshot = aislesDataSource.snapshot()
        aislesSnapshot.appendSections([department])
        aislesDataSource.apply(aislesSnapshot)
    }
    
    func applyDepartmentSnapshot(departments: [Department]) {
        var snapshot = alternativeDataSource.snapshot()
        snapshot.appendSections(["department"])
        snapshot.appendItems(departments, toSection: "department")
        alternativeDataSource.apply(snapshot)
    }
    
    func applyFeaturedSnapshot(promotions: [BranchPromotion]?) {
        guard let promotions = promotions else { return }
        var snapshot = featuredDataSource.snapshot()
        snapshot.appendSections(["promotion"])
        snapshot.appendItems(promotions, toSection: "promotion")
        featuredDataSource.apply(snapshot)
    }
    
    func configureWith(_ branch: Branch) {
        guard self.branch != branch else { return }
        self.branch = branch
        fetchBranch(branch.identifier)
    }
    
}

extension BranchPresenter: BranchPresenterDelegate {
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
        if collectionView == mainView.branchCollectionView.featuredDepartmentCollectionView {
            guard let url = branchDetailContainer?.branch.featured?[indexPath.row].url else { return }
            debugPrint("Tap on promotion \(url)")
            return
        }
        if collectionView == mainView.aislesCollectionView.collectionView {
            if let department = branchDetailContainer?.departments[indexPath.section].aisles[indexPath.row].department {
                departmentPresenter?.configureWith(department, product: nil)
                viewController.push()
            }
            if let id = branchDetailContainer?.departments[indexPath.section].aisles[indexPath.row].identifier {
                debugPrint("Tap on aisle id \(id)")
            }
            return
        }
        guard let department = branchDetailContainer?.departments[indexPath.section] else {
            debugPrint("Nanai")
            return
        }
        let product = department.topProducts[indexPath.row]
        departmentPresenter?.configureWith(department, product: product)
        viewController.push()
    }
}
