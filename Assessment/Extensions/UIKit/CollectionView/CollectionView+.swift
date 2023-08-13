//
//  CollectionView+.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

extension UICollectionView {
    
    /// Use this when your cell is created in a Nib file
    /// - Parameter type: Type of `UICollectionViewCell` subclass (ex. SimpleCollectionViewCell.self)
    func registerNib<C: UICollectionViewCell>(forType type: C.Type) {
        register(
            UINib(
                nibName: type.reuseIdentifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: type.reuseIdentifier
        )
    }
    
    /// Dequeue cell directly with desired type
    /// - Parameters:
    ///   - type: `UICollectionViewCell` subclass type (ex. SimpleCollectionViewCell.self)
    ///   - indexPath: index path for cell to dequeue
    /// - Returns: `UICollectionViewCell` instance of specified type
    func dequeueReusableCell<C: UICollectionViewCell>(
        ofType type: C.Type,
        for indexPath: IndexPath
    ) -> C {
        let cell = dequeueReusableCell(
            withReuseIdentifier: type.reuseIdentifier,
            for: indexPath
        )
        guard let typedCell = cell as? C else {
            fatalError("Could not dequeue reusable cell of type \(type)")
        }
        return typedCell
    }
    
    /// Use this wen your header is created in a Nib file
    /// - Parameters:
    ///   - type: type of `UICollectionReusableView` subclass
    ///   - kind: kinf of supplimentary view like `UICollection.elementKindHeader`
    func registerNib<C: UICollectionReusableView>(forType type: C.Type, ofKind kind: String) {
        register(
            UINib(
                nibName: type.viewName,
                bundle: nil
            ),
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: type.viewName
        )
    }

    /// Dequeue supplemantary directly with desired type
    /// - Parameters:
    ///   - type: `UICollectionReusableView` subclass type (ex. HeaderReusableView.self)
    ///   - indexPath: index path for cell to dequeue
    /// - Returns: `UICollectionReusableView` instance of specified type
    func dequeueReusableHeaderView<C: UICollectionReusableView>(
        ofKind kind: String,
        ofType type: C.Type,
        for indexPath: IndexPath
    ) -> C {

        let view = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: type.viewName,
            for: indexPath
        )

        guard let typedView = view as? C else {
            fatalError("Could not dequeue reusable view of type \(type)")
        }

        return typedView

    }
    
}
