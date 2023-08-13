//
//  MealIngredientsCell.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

class MealIngredientsCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var ingredientLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 7
    }

    // MARK: - Functionalities
    
    internal func configure(with ingredient: String) {
        ingredientLabel.text = ingredient
    }

}
