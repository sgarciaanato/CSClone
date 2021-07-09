//
//  AisleSectionHeader.swift
//  CSClone
//
//  Created by Samuel García on 7/7/21.
//

import UIKit

class AisleSectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "AisleSectionHeader"
    
    let title: UILabel!
    let iconImage: UIImageView!
    var separatorView: UIView!
    var department: Department?
    var delegate: AisleDepartmentDelegate?
    
    override init(frame: CGRect) {
        title = UILabel()
        iconImage = UIImageView()
        separatorView = UIView()
        super.init(frame: frame)
        title.textColor = .label
        iconImage.contentMode = .scaleAspectFit
        iconImage.clipsToBounds = true
        self.addSubview(iconImage)
        self.addSubview(title)
        self.addSubview(separatorView)
        title.translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor),
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 4),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: title.trailingAnchor)
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapDepartment))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapDepartment() {
        delegate?.selectAisleDepartment(department)
    }
    
    func configure(department: Department, product: Product?) {
        title.text = department.name
        self.department = department
        if let product = product {
            iconImage.downloadImage(from: product.imgUrl)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
