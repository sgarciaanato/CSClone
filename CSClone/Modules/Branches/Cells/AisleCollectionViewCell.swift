//
//  AisleCollectionViewCell.swift
//  CSClone
//
//  Created by Samuel García on 7/7/21.
//

import UIKit

class AisleCollectionViewCell: UICollectionViewCell, SelfConfiguringAisleCell {
    static let reuseIdentifier: String = "AisleCollectionViewCell"
    let titleLabel: UILabel!
    var separatorView: UIView!
    
    override init(frame: CGRect) {
        self.titleLabel = UILabel()
        self.separatorView = UIView()
        super.init(frame: .zero)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(separatorView)
        separatorView.backgroundColor = .lightGray
        configureConstraints()
    }
    
    func configureConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(_ aisle: Aisle) {
        titleLabel.text = aisle.name
    }
}
