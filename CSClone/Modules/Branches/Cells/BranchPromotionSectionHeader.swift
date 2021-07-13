//
//  BranchPromotionSectionHeader.swift
//  CSClone
//
//  Created by Samuel García on 7/9/21.
//

import UIKit

class BranchPromotionSectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "BranchPromotionSectionHeader"
    let imageView: UIImageView!
    let titleLabel: UILabel!
    
    override init(frame: CGRect) {
        self.imageView = UIImageView()
        self.titleLabel = UILabel()
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    func configureViews() {
        addSubview(imageView)
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
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -18),
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }
    
    func configure(promotion: BranchPromotion) {
        guard let x3 = promotion.imageSet?.x3 else { return }
        imageView.backgroundColor = UIColor.hexStringToUIColor(hex: promotion.backgroundColor)
        imageView.downloadImage(from: x3)
        titleLabel.text = promotion.caption
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
