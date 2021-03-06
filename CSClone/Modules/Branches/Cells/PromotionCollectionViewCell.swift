//
//  PromotionCollectionViewCell.swift
//  CSClone
//
//  Created by Samuel García on 7/6/21.
//

import UIKit

class PromotionCollectionViewCell: UICollectionViewCell, SelfConfiguringPromotionCell {
    static let reuseIdentifier: String = "PromotionCollectionViewCell"
    let imageView: UIImageView!
    let titleLabel: UILabel!
    
    override init(frame: CGRect) {
        self.imageView = UIImageView()
        self.titleLabel = UILabel()
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
    }
    
    func configureViews() {
        contentView.addSubview(imageView)
        addSubview(titleLabel)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        titleLabel.textColor = UIColor.white
    }
    
    func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -18),
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(_ promotion: BranchPromotion?) {
        guard let prom = promotion, let x3 = prom.imageSet?.x3 else { return }
        imageView.backgroundColor = UIColor.hexStringToUIColor(hex: prom.backgroundColor)
        imageView.downloadImage(from: x3)
        titleLabel.text = prom.caption
    }
}
