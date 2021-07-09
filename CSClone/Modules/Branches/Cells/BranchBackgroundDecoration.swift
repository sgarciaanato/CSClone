//
//  BranchBackgroundDecoration.swift
//  CSClone
//
//  Created by Samuel García on 7/5/21.
//

import UIKit

class BranchBackgroundDecoration: UICollectionReusableView {
    static let reuseIdentifier = "BranchBackgroundDecoration"
    
    private var insetView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .secondarySystemFill
            view.layer.cornerRadius = 15
            view.clipsToBounds = true
            return view
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .clear
            addSubview(insetView)

            NSLayoutConstraint.activate([
                insetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                trailingAnchor.constraint(equalTo: insetView.trailingAnchor, constant: 15),
                insetView.topAnchor.constraint(equalTo: topAnchor),
                insetView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
