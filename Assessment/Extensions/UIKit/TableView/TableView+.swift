//
//  TableView+.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

extension UITableView {
    
    /// Use this when your cell is created in Storyboard itself.
    /// - Parameter type: Type of TableViewCell subclass (ex. SimpleTableViewCell.self)
    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        register(
            type,
            forCellReuseIdentifier: type.reuseIdentifier
        )
    }

    /// Use this when your cell is created in a Nib file
    /// - Parameter type: Type of TableViewCell subclass (ex. SimpleTableViewCell.self)
    func registerNib<T: UITableViewCell>(forType type: T.Type) {
        register(
            UINib(
                nibName: type.reuseIdentifier,
                bundle: nil
            ),
            forCellReuseIdentifier: type.reuseIdentifier
        )
    }
    
    /// Dequeue cell directly with desired type
    /// - Parameters:
    ///   - type: UITableViewCell subclass type (ex. SimpleTableViewCell.self)
    ///   - indexPath: index path for cell to dequeue
    /// - Returns: UITableViewCell subclass object of specified type.
    func dequeueReusableCell<T: UITableViewCell>(
        ofType type: T.Type,
        for indexPath: IndexPath? = nil
    ) -> T {
        let cell: UITableViewCell?
        switch indexPath {
        case .some(let indexPath):
            cell = dequeueReusableCell(
                withIdentifier: type.reuseIdentifier,
                for: indexPath
            )
        case .none:
            cell = dequeueReusableCell(
                withIdentifier: type.reuseIdentifier
            )
        }
        guard let typedCell = cell as? T else {
            fatalError("Could not dequeue reusable cell of type \(type)")
        }
        return typedCell
    }
    
}
