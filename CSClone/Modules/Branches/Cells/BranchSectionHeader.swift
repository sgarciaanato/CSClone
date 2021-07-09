//
//  BranchSectionHeader.swift
//  CSClone
//
//  Created by Samuel García on 7/5/21.
//

import UIKit

class BranchSectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "BranchSectionHeader"
    
    let title: UILabel!
    let backgroundImage: UIImageView!
    var department: Department?
    var delegate: BranchDepartmentDelegate?
    
    override init(frame: CGRect) {
        title = UILabel()
        backgroundImage = UIImageView()
        super.init(frame: frame)
        title.textColor = .white
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        self.addSubview(backgroundImage)
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapDepartment))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapDepartment() {
        delegate?.selectDepartment(department)
    }
    
    func configure(department: Department) {
        title.text = department.name
        backgroundImage.downloadImage(from: department.imgUrl)
        self.department = department
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
