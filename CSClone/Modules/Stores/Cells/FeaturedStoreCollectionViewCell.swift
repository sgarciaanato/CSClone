//
//  FeaturedStoreCollectionViewCell.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

import UIKit

class FeaturedStoreCollectionViewCell: UICollectionViewCell, SelfConfiguringStoreCell {
    static let reuseIdentifier: String = "FeaturedStoreCollectionViewCell"
    let imageView: UIImageView!
    
    override init(frame: CGRect) {
        self.imageView = UIImageView()
        super.init(frame: .zero)
        self.contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        layer.cornerRadius = 5
        configureConstraints()
    }
    
    func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let topAnchor = self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        let leadingAnchor = self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailingAnchor = self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let bottomAnchor = self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        
        topAnchor.priority = UILayoutPriority(rawValue: 999)
        leadingAnchor.priority = UILayoutPriority(rawValue: 999)
        trailingAnchor.priority = UILayoutPriority(rawValue: 999)
        bottomAnchor.priority = UILayoutPriority(rawValue: 999)
        
        NSLayoutConstraint.activate([
            topAnchor,
            leadingAnchor,
            trailingAnchor,
            bottomAnchor
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(_ storeItem: StoreItem) {
        if let brandColor = storeItem.content.brandColor{
            self.backgroundColor = UIColor.hexStringToUIColor(hex: brandColor)
        }
        if let imgUrl = storeItem.content.imgUrl {
            imageView.downloadImage(from: imgUrl)
        }
    }
}
