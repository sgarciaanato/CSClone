//
//  ProductCollectionViewCell.swift
//  CSClone
//
//  Created by Samuel García on 7/5/21.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell, SelfConfiguringProductCell {
    static let reuseIdentifier: String = "ProductCollectionViewCell"
    let container: UIStackView!
    let imageView: UIImageView!
    let titleLabel: UILabel!
    let priceLabel: UILabel!
    let descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        self.container = UIStackView()
        self.imageView = UIImageView()
        self.titleLabel = UILabel()
        self.priceLabel = UILabel()
        self.descriptionLabel = UILabel()
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
    }
    
    func configureViews() {
        contentView.addSubview(container)
        contentView.backgroundColor = UIColor.systemBackground
        container.axis = .vertical
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(priceLabel)
        container.addArrangedSubview(descriptionLabel)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        titleLabel.textAlignment = .center
        priceLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        titleLabel.numberOfLines = 3
        priceLabel.textColor = .secondaryLabel
        descriptionLabel.textColor = .secondaryLabel
        imageView.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
    }
    
    func configureConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(_ product: Product) {
        imageView.downloadImage(from: product.imgUrl)
        titleLabel.text = "\(product.brand.name) · \(product.name)"
        priceLabel.text = "\(product.pricing.price.amount) \(product.pricing.price.currency)"
        descriptionLabel.text = product.package
    }
}
