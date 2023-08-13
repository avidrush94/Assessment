//
//  MealOverviewCell.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit
import Kingfisher

class MealOverviewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var placeholderImage: UIImage = {
        return UIImage(systemName: "fork.knife")!
            .withRenderingMode(.alwaysTemplate)
            .withTintColor(.lightGray)
    }()
    
    var onImageTap: ((_ sender: UIButton) -> Void)? = nil

    // MARK: - Outlets
    
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var thumbnailImageView: UIButton!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var tagsLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction private func showImage(_ sender: UIButton) {
        onImageTap?(sender)
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 7
        containerView.clipsToBounds = true
        
        thumbnailImageView.layer.cornerRadius = 7
        thumbnailImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.setImage(placeholderImage, for: .normal)
        nameLabel.text = nil
        categoryLabel.text = nil
        tagsLabel.text = nil
    }
    
    // MARK: - Functionaltities
    
    internal func configure(with meal: Meal) {
        nameLabel.text = meal.name
        
        categoryLabel.text = meal.category
        categoryLabel.isHidden = categoryLabel.text?.isEmpty ?? true
        
//        tagsLabel.text = meal.tags
//        tagsLabel.isHidden = tagsLabel.text?.isEmpty ?? true
        
        if let thumbnailURL = meal.thumbnail,
           let url = URL(string: thumbnailURL) {
            thumbnailImageView.kf.setImage(
                with: url,
                for: .normal,
                placeholder: placeholderImage
            )
        } else {
            thumbnailImageView.setImage(placeholderImage, for: .normal)
        }
    }

}
