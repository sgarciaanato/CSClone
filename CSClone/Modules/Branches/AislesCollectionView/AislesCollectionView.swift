//
//  AislesCollectionView.swift
//  CSClone
//
//  Created by Samuel García on 7/7/21.
//

import UIKit

class AislesCollectionView: UIView {
    var branchDetailContainer: BranchDetailContainer? {
        didSet {
            self.collectionView.collectionViewLayout = createCompositionalLayout()
        }
    }
    var delegate: UICollectionViewDelegate? {
        didSet {
            collectionView.delegate = delegate
        }
    }
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let layoutSectionBuilder: AislesLayoutSectionBuilder!
    
    init() {
        layoutSectionBuilder = AislesLayoutSectionBuilder()
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
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            return self.layoutSectionBuilder.createAislesSection()
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration ()
        configuration.interSectionSpacing = 20
        layout.configuration = configuration
        return layout
    }
}
