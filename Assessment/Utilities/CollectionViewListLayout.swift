//
//  CollectionViewListLayout.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

final class CollectionViewListLayout: UICollectionViewCompositionalLayout {
    
    init() {
        super.init { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .estimated(90))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(90))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(12)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.interGroupSpacing = 12
            section.contentInsets = .init(top: 12, leading: 0, bottom: 12, trailing: 0)

            return section
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
