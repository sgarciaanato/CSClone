//
//  DepartmentCollectionViewCell.swift
//  CSClone
//
//  Created by Samuel García on 7/9/21.
//

import UIKit

class DepartmentCollectionViewCell: UICollectionViewCell, SelfConfiguringDepartmentCell {
    static let reuseIdentifier: String = "DepartmentCollectionViewCell"
    let headerBackgroundImageView: UIImageView!
    let departmentTitleLabel: UILabel!
    let productCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Department, Product>!
    let layoutSectionBuilder: AlternativeBranchLayoutSectionBuilder!
    var department: Department?
    var delegate: BranchPresenterDelegate?
    
    override init(frame: CGRect) {
        headerBackgroundImageView = UIImageView()
        departmentTitleLabel = UILabel()
        productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        layoutSectionBuilder = AlternativeBranchLayoutSectionBuilder()
        super.init(frame: .zero)
        configureViews()
        configureConstraint()
        configureDataSource()
    }
    
    func configureViews(){
        self.contentView.addSubview(headerBackgroundImageView)
        self.contentView.addSubview(departmentTitleLabel)
        self.contentView.addSubview(productCollectionView)
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 6
        headerBackgroundImageView.clipsToBounds = true
        headerBackgroundImageView.contentMode = .scaleAspectFill
        departmentTitleLabel.textColor = UIColor.white
        productCollectionView.backgroundColor = .systemGroupedBackground
        productCollectionView.delegate = self
    }
    
    func configureConstraint(){
        headerBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        departmentTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        productCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerBackgroundImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            headerBackgroundImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            headerBackgroundImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            headerBackgroundImageView.heightAnchor.constraint(equalToConstant: 40),
            departmentTitleLabel.topAnchor.constraint(equalTo: headerBackgroundImageView.topAnchor),
            departmentTitleLabel.leadingAnchor.constraint(equalTo: headerBackgroundImageView.leadingAnchor),
            departmentTitleLabel.trailingAnchor.constraint(equalTo: headerBackgroundImageView.trailingAnchor),
            departmentTitleLabel.bottomAnchor.constraint(equalTo: headerBackgroundImageView.bottomAnchor),
            productCollectionView.topAnchor.constraint(equalTo: headerBackgroundImageView.bottomAnchor),
            productCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    func configureDataSource() {
        productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        dataSource = UICollectionViewDiffableDataSource<Department, Product>(collectionView: productCollectionView) { (collectionView, indexPath, product) -> UICollectionViewCell? in
            self.configure(ProductCollectionViewCell.self, with: product, for: indexPath)
        }
    }
    
    func configure<T: SelfConfiguringProductCell>(_ cellType: T.Type, with product: Product, for indexPath: IndexPath) -> T {
        guard let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configureWith(product)
        return cell
    }
    
    func applySnapshot(department: Department) {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([department])
        snapshot.appendItems(department.topProducts, toSection: department)
        dataSource.apply(snapshot)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            return self.layoutSectionBuilder.createProductSection()
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration ()
        configuration.interSectionSpacing = 20
        layout.configuration = configuration
        return layout
    }
    
    func resetSnapshot() {
        guard let department = self.department else { return }
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.deleteSections([department])
        dataSource.apply(snapshot)
    }
    
    func configureWith(_ department: Department) {
        if department == self.department { return }
        resetSnapshot()
        self.department = department
        headerBackgroundImageView.downloadImage(from: department.imgUrl)
        departmentTitleLabel.text = department.name
        productCollectionView.collectionViewLayout = createCompositionalLayout()
        applySnapshot(department: department)
        productCollectionView.bounces = false
        productCollectionView.alwaysBounceVertical = false
        productCollectionView.alwaysBounceHorizontal = false
    }
}

extension DepartmentCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = department?.topProducts[indexPath.row], let department = self.department else { return }
        delegate?.selectProduct(product: product, department: department)
    }
}
