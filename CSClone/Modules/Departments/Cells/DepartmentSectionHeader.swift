//
//  DepartmentSectionHeader.swift
//  CSClone
//
//  Created by Samuel García on 7/6/21.
//

import UIKit

class DepartmentSectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "DepartmentSectionHeader"
    
    let title: UILabel!
    
    override init(frame: CGRect) {
        title = UILabel()
        super.init(frame: frame)
        title.textColor = .label
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(aisle: Aisle) {
        title.text = aisle.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
