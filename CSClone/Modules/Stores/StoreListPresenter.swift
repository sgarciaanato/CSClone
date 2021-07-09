//
//  StoreListPresenter.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

import UIKit

class StoreListPresenter {
    
    var branchPresenter: BranchPresenter?
    
    let service = StoreListService()
    
    var stores: [StoreContainer]? {
        didSet {
            _viewController?.mainView.stores = stores
        }
    }
    
    private var _viewController: StoreListViewController?
    var viewController: StoreListViewController {
        if let viewController = _viewController {
            return viewController
        }
        let viewController = StoreListViewController()
        viewController.presenter = self
        _viewController = viewController
        return viewController
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<StoreContainer, StoreItem>!
    func configureDataSource() {
        guard let mainView = _viewController?.mainView else { return }
        mainView.collectionView.register(FeaturedStoreCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedStoreCollectionViewCell.reuseIdentifier)
        mainView.collectionView.register(StoreCollectionViewCell.self, forCellWithReuseIdentifier: StoreCollectionViewCell.reuseIdentifier)
        mainView.collectionView.register(PosterStoreCollectionViewCell.self, forCellWithReuseIdentifier: PosterStoreCollectionViewCell.reuseIdentifier)
        mainView.collectionView.register(StoreSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StoreSectionHeader.reuseIdentifier)
        dataSource = UICollectionViewDiffableDataSource<StoreContainer, StoreItem>(collectionView: mainView.collectionView) { (collectionView, indexPath, storeItem) -> UICollectionViewCell? in
            guard let store = self.stores?[indexPath.section] else { return UICollectionViewCell() }
            
            switch store.style.type {
            case "classic":
                return self.configure(FeaturedStoreCollectionViewCell.self, with: storeItem, for: indexPath)
            case "list":
                return self.configure(StoreCollectionViewCell.self, with: storeItem, for: indexPath)
            case "posters":
                return self.configure(PosterStoreCollectionViewCell.self, with: storeItem, for: indexPath)
            default:
                return self.configure(FeaturedStoreCollectionViewCell.self, with: storeItem, for: indexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StoreSectionHeader.reuseIdentifier, for: indexPath) as? StoreSectionHeader else { return nil }
            
            guard let store = self?.stores?[indexPath.section] else { return nil }
            if store.name.isEmpty { return nil }
            sectionHeader.title.text = store.name
            
            return sectionHeader
        }
    }
    
    func configure<T: SelfConfiguringStoreCell>(_ cellType: T.Type, with store: StoreItem, for indexPath: IndexPath) -> T {
        guard let cell = _viewController?.mainView.collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(store)
        return cell
    }
    
    func fetchStores() {
        guard let stores = service.getStores() else { return }
        self.stores = stores
        for store in stores {
            applySnapshot(storeContainer: store)
        }
    }
    
    func applySnapshot(storeContainer: StoreContainer) {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([storeContainer])
        snapshot.appendItems(storeContainer.items)
        dataSource.apply(snapshot)
    }
}

extension StoreListPresenter: StoreListPresenterDelegate {
    func viewDidLoad() {
        configureDataSource()
        fetchStores()
    }
}
