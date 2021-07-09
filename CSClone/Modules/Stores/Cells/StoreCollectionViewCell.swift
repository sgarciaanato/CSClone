//
//  StoreCollectionViewCell.swift
//  CSClone
//
//  Created by Samuel García on 6/30/21.
//

import UIKit

class StoreCollectionViewCell: UICollectionViewCell, SelfConfiguringStoreCell {
    static let reuseIdentifier: String = "StoreCollectionViewCell"
    let container: UIView!
    let imageView: UIImageView!
    let titleLabel: UILabel!
    let subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        self.container = UIView()
        self.imageView = UIImageView()
        self.titleLabel = UILabel()
        self.subtitleLabel = UILabel()
        super.init(frame: .zero)
        self.contentView.addSubview(container)
        self.container.addSubview(imageView)
        self.container.addSubview(titleLabel)
        self.container.addSubview(subtitleLabel)
        imageView.contentMode = .scaleAspectFit
        container.clipsToBounds = true
        self.imageView.layer.cornerRadius = 5
        titleLabel.numberOfLines = 2
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textColor = .darkGray
        configureConstraints()
    }
    
    func configureConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(_ storeItem: StoreItem) {
        if let brandColor = storeItem.content.brandColor{
            self.imageView.backgroundColor = UIColor.hexStringToUIColor(hex: brandColor)
        }
        self.titleLabel.text = storeItem.content.name
        self.subtitleLabel.text = storeItem.content.excerpt
        if let imgUrl = storeItem.content.imgUrl {
            imageView.downloadImage(from: imgUrl)
        }
    }
}
