//
//  BranchViewControllerContainer.swift
//  CSClone
//
//  Created by Samuel García on 7/7/21.
//

import UIKit

class BranchViewControllerContainer: UIView {
    
    var branchCollectionView: BranchCollectionView!
    var aislesCollectionView: AislesCollectionView!
    var alternativeBranchCollectionView: AlternativeBranchCollectionView!
    var buttonsStackView: UIStackView!
    var featuredButton: UIButton!
    var aislesButton: UIButton!
    var alternativeBranchButton: UIButton!
    var buttonsArray: [UIButton]!
    
    init() {
        branchCollectionView = BranchCollectionView()
        aislesCollectionView = AislesCollectionView()
        alternativeBranchCollectionView = AlternativeBranchCollectionView()
        buttonsStackView = UIStackView()
        featuredButton = UIButton()
        aislesButton = UIButton()
        alternativeBranchButton = UIButton()
        buttonsArray = [featuredButton, aislesButton, alternativeBranchButton]
        super.init(frame: .zero)
        self.addSubview(branchCollectionView)
        self.addSubview(aislesCollectionView)
        self.addSubview(buttonsStackView)
        self.addSubview(alternativeBranchCollectionView)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        aislesCollectionView.isHidden = true
        alternativeBranchCollectionView.isHidden = true
        for button in buttonsArray {
            buttonsStackView.addArrangedSubview(button)
            button.layer.borderColor = UIColor.systemPink.cgColor
            button.setTitleColor(.systemPink, for: .normal)
            button.layer.cornerRadius = 8
            button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        }
        featuredButton.backgroundColor = .systemPink
        featuredButton.setTitleColor(UIColor.systemBackground, for: .normal)
        
        featuredButton.setTitle("Featured", for: .normal)
        aislesButton.setTitle("Aisles", for: .normal)
        alternativeBranchButton.setTitle("Alternative", for: .normal)
        
        featuredButton.addTarget(self, action: #selector(tapFeature), for: .touchUpInside)
        aislesButton.addTarget(self, action: #selector(tapAisles), for: .touchUpInside)
        alternativeBranchButton.addTarget(self, action: #selector(tapAlternativeBranch), for: .touchUpInside)
    }
    
    func configureConstraints(){
        branchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        aislesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        alternativeBranchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        let bottomBranchCollectionConstraint = branchCollectionView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor)
        let bottomAislesCollectionConstraint = aislesCollectionView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor)
        bottomBranchCollectionConstraint.priority = UILayoutPriority(750)
        bottomAislesCollectionConstraint.priority = UILayoutPriority(750)
        for view in [branchCollectionView, aislesCollectionView, alternativeBranchCollectionView] {
            NSLayoutConstraint.activate([
                view!.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                view!.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                view!.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
                view!.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor),
            ])
        }
        NSLayoutConstraint.activate([
            buttonsStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            buttonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    @objc func tapFeature() {
        if !branchCollectionView.isHidden { return }
        for button in buttonsArray {
            button.layer.borderColor = UIColor.systemPink.cgColor
            button.backgroundColor = UIColor.clear
            button.setTitleColor(.systemPink, for: .normal)
        }
        featuredButton.backgroundColor = .systemPink
        featuredButton.setTitleColor(UIColor.systemBackground, for: .normal)
        aislesCollectionView.isHidden = true
        alternativeBranchCollectionView.isHidden = true
        branchCollectionView.isHidden = false
    }
    
    @objc func tapAisles() {
        if !aislesCollectionView.isHidden { return }
        for button in buttonsArray {
            button.layer.borderColor = UIColor.systemPink.cgColor
            button.backgroundColor = UIColor.clear
            button.setTitleColor(.systemPink, for: .normal)
        }
        aislesButton.backgroundColor = .systemPink
        aislesButton.setTitleColor(UIColor.systemBackground, for: .normal)
        branchCollectionView.isHidden = true
        alternativeBranchCollectionView.isHidden = true
        aislesCollectionView.isHidden = false
    }
    
    @objc func tapAlternativeBranch() {
        for button in buttonsArray {
            button.layer.borderColor = UIColor.systemPink.cgColor
            button.backgroundColor = UIColor.clear
            button.setTitleColor(.systemPink, for: .normal)
        }
        alternativeBranchButton.backgroundColor = .systemPink
        alternativeBranchButton.setTitleColor(UIColor.systemBackground, for: .normal)
        branchCollectionView.isHidden = true
        aislesCollectionView.isHidden = true
        alternativeBranchCollectionView.isHidden = false
    }
    
}
