//
//  AlternativeBranchCollectionView.swift
//  CSClone
//
//  Created by Samuel García on 7/9/21.
//

import UIKit

class AlternativeBranchCollectionView: UIView {
    
    var branchDetailContainer: BranchDetailContainer? {
        didSet {
            self.collectionView.collectionViewLayout = createCompositionalLayout()
            self.featuredDepartmentCollectionView.collectionViewLayout = createFeaturedCompositionalLayout()
        }
    }
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    lazy var featuredDepartmentCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFeaturedCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.clipsToBounds = false
        return collectionView
    }()
    
    let layoutSectionBuilder: AlternativeBranchLayoutSectionBuilder!
    let layoutFeaturedSectionBuilder: AlternativeBranchLayoutFeaturedSectionBuilder!
    
    init() {
        layoutSectionBuilder = AlternativeBranchLayoutSectionBuilder()
        layoutFeaturedSectionBuilder = AlternativeBranchLayoutFeaturedSectionBuilder()
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        self.addSubview(collectionView)
        collectionView.addSubview(featuredDepartmentCollectionView)
        collectionView.backgroundColor = .systemGroupedBackground
        featuredDepartmentCollectionView.backgroundColor = .systemGroupedBackground
    }
    func configureConstraints() {
        collectionView.contentInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
        NSLayoutConstraint.activate([
            self.featuredDepartmentCollectionView.leadingAnchor.constraint(equalTo: self.collectionView.frameLayoutGuide.leadingAnchor, constant: 24),
            self.featuredDepartmentCollectionView.trailingAnchor.constraint(equalTo: self.collectionView.frameLayoutGuide.trailingAnchor, constant: -24),
            self.featuredDepartmentCollectionView.bottomAnchor.constraint(equalTo: self.collectionView.contentLayoutGuide.topAnchor),
            self.featuredDepartmentCollectionView.heightAnchor.constraint(equalToConstant: 180),
            self.collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            return self.layoutSectionBuilder.createDepartmentSection()
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        layout.configuration = configuration
        return layout
    }
    
    private func createFeaturedCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            return self.layoutFeaturedSectionBuilder.createFeaturedDepartmentSection()
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration ()
        configuration.scrollDirection = .horizontal
        layout.configuration = configuration
        return layout
    }
}
