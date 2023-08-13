//
//  MealDetailSectionHeaderView.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

class MealDetailSectionHeaderView: UICollectionReusableView {

    // MARK: - Outlets
    
    @IBOutlet weak private var headerLabel: UILabel!
    
    // MARK: - Functionalities
    
    internal func set(header label: String) {
        headerLabel.text = label
    }
    
}
