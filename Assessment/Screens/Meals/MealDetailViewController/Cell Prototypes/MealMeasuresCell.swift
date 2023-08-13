//
//  MealMeasuresCell.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

class MealMeasuresCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var measureLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 7
    }

    // MARK: - Functionalities
    
    internal func configure(with measure: String) {
        measureLabel.text = measure
    }

}
