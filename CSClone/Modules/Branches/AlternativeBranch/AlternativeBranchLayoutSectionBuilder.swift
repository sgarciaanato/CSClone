//
//  AlternativeBranchLayoutSectionBuilder.swift
//  CSClone
//
//  Created by Samuel García on 7/9/21.
//

import UIKit

class AlternativeBranchLayoutSectionBuilder {
    
    func createDepartmentSection(layoutEnviroment: NSCollectionLayoutEnvironment, branchDepartmentPresenter: BranchDepartmentDelegate?, department: Department?) -> NSCollectionLayoutSection {
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
            let seeMore = UIContextualAction(style: .normal, title: nil) {
                action, view, completion in
                guard let department = department else {
                    completion(false)
                    return
                }
                branchDepartmentPresenter?.selectDepartment(department)
                completion(true)
            }
            seeMore.image = UIImage(systemName: "plus.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemPink)
            seeMore.backgroundColor = .systemGroupedBackground
            return UISwipeActionsConfiguration(actions: [seeMore])
        }
        let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnviroment)
        section.interGroupSpacing = 10
        
        return section
    }
    
    func createProductSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.5, leading: 0.5, bottom: 0.5, trailing: 0.5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3334),heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func createContextualButton() -> UIView {
        let view = UIView()
        let imageView = UIImageView(image: UIImage(systemName: "plus.circle"))
        let label = UILabel()
        label.text = "See more"
        label.sizeToFit()
        view.addSubview(imageView)
        view.addSubview(label)
        view.backgroundColor = UIColor.purple
        view.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        return view
    }
}

extension UIImage {

    /// This method creates an image of a view
    convenience init?(view: UIView) {

        // Based on https://stackoverflow.com/a/41288197/1118398
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        let image = renderer.image { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }

        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        } else {
            return nil
        }
    }
}

class OriginalImageRender: UIImage {
override func withRenderingMode(_ renderingMode: UIImage.RenderingMode) -> UIImage {
    self.withTintColor(.systemPink)
    return self
} }
