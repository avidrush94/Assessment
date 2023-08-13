//
//  MealDetailLayout.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

final class MealDetailLayout: UICollectionViewCompositionalLayout {
    
    init() {
        super.init { section, _ in
            switch section {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .estimated(90))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(90))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(12)

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.interGroupSpacing = 12
                section.contentInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)

                return section
                
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(60),
                                                            heightDimension: .estimated(30))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 6, bottom: 0, trailing: 6)

                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(60),
                                                       heightDimension: .estimated(30))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(6)
                
                let headerSize = NSCollectionLayoutSize(
                  widthDimension: .fractionalWidth(1.0),
                  heightDimension: .absolute(30))

                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading
                )

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 6
                section.contentInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)
                section.boundarySupplementaryItems = [sectionHeader]

                return section
                
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(60),
                                                            heightDimension: .estimated(30))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 6, bottom: 0, trailing: 6)

                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(60),
                                                       heightDimension: .estimated(30))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(6)
                
                let headerSize = NSCollectionLayoutSize(
                  widthDimension: .fractionalWidth(1.0),
                  heightDimension: .absolute(30))

                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading
                )

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 6
                section.contentInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)
                section.boundarySupplementaryItems = [sectionHeader]

                return section
                
            default: fatalError("Unknown number of sections.")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
