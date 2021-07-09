//
//  StoreLayoutSectionBuilder.swift
//  CSClone
//
//  Created by Samuel García on 6/29/21.
//

import UIKit

class StoreLayoutSectionBuilder {
    
    func createClassicSection(attribute: StoreStyleAttributes, enviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let effectiveWidth = enviroment.container.effectiveContentSize.width
        
        var itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),heightDimension: .fractionalHeight(1))
        if attribute.preferredOrientation == "horizontal" {
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.5))
        }
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        var groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalWidth(0.5))
        var group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitem: item, count: 2)
        if attribute.preferredOrientation == "horizontal" {
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(effectiveWidth < 375 ? 0.93 : 0.465),heightDimension: .absolute(300))
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,subitem: item, count: 2)
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        if attribute.preferredOrientation == "horizontal" {
            section.orthogonalScrollingBehavior = .groupPaging
        }
        return section
        
    }
    
    func createListSection(attribute: StoreStyleAttributes, enviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1/3))
        switch attribute.preferredSize {
        case "large":
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.25))
            break;
        case "small":
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.5))
            break;
        default: break
        }
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0)
        
        var groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.63),heightDimension: .fractionalWidth(0.75))
        switch attribute.preferredSize {
        case "large":
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.63),heightDimension: .fractionalWidth(1))
            break;
        case "small":
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.63),heightDimension: .fractionalWidth(0.5))
            break;
        default: break
        }
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let layoutSectioHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectioHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [layoutSectionHeader]
        return section
    }
    
    func createPostersSection(attribute: StoreStyleAttributes, enviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93),heightDimension: .estimated(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let layoutSectioHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectioHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [layoutSectionHeader]
        return section
    }
}
