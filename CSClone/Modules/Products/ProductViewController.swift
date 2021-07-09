//
//  ProductViewController.swift
//  CSClone
//
//  Created by Samuel García on 7/6/21.
//

import UIKit

class ProductViewController: UIViewController {
    let stackview: UIStackView!
    let imageView: UIImageView!
    let titleLabel: UILabel!
    let priceLabel: UILabel!
    let descriptionLabel: UILabel!
    
    init() {
        stackview = UIStackView()
        imageView = UIImageView()
        titleLabel = UILabel()
        priceLabel = UILabel()
        descriptionLabel = UILabel()
        super.init(nibName: nil, bundle: nil)
        configureViews()
    }
    
    func configureViews() {
        self.view.addSubview(stackview)
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.addArrangedSubview(imageView)
        stackview.addArrangedSubview(titleLabel)
        stackview.addArrangedSubview(priceLabel)
        stackview.addArrangedSubview(descriptionLabel)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        titleLabel.textAlignment = .center
        priceLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        titleLabel.numberOfLines = 3
        priceLabel.textColor = .secondaryLabel
        descriptionLabel.textColor = .secondaryLabel
    }
    
    func configureConstraints() {
        stackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackview.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            stackview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.systemGroupedBackground
        configureConstraints()
    }
    
    func configureWith(_ product: Product) {
        imageView.downloadImage(from: product.imgUrl)
        titleLabel.text = "\(product.brand.name) · \(product.name)"
        priceLabel.text = "\(product.pricing.price.amount) \(product.pricing.price.currency)"
        descriptionLabel.text = product.package
    }
}
