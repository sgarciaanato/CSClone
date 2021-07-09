//
//  StoreListCollectionView.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

import UIKit

class StoreListCollectionView: UIView {
    
    let layoutSectionBuilder: StoreLayoutSectionBuilder!
    var delegate: StoreListCollectionViewDelegate?
    
    var stores: [StoreContainer]? {
        didSet {
            self.collectionView.collectionViewLayout = createCompositionalLayout()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        return collectionView
    }()
    
    init() {
        layoutSectionBuilder = StoreLayoutSectionBuilder()
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        collectionView.backgroundColor = UIColor.systemGroupedBackground
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        guard let stores = stores else { return UICollectionViewLayout() }
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            let store = stores[sectionIndex]
            switch store.style.type {
            case "classic":
                return self.layoutSectionBuilder.createClassicSection(attribute: store.style.attributes, enviroment: layoutEnviroment)
            case "list":
                return self.layoutSectionBuilder.createListSection(attribute: store.style.attributes, enviroment: layoutEnviroment)
            case "posters":
                return self.layoutSectionBuilder.createPostersSection(attribute: store.style.attributes, enviroment: layoutEnviroment)
            default:
                return self.layoutSectionBuilder.createListSection(attribute: store.style.attributes, enviroment: layoutEnviroment)
            }
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration ()
        configuration.interSectionSpacing = 20
        layout.configuration = configuration
        return layout
    }
}

extension StoreListCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let branch = stores?[indexPath.section].items[indexPath.row].content else { fatalError("No branch found") }
        delegate?.selectBranch(branch)
    }
}
