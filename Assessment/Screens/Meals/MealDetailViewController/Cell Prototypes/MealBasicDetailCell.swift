//
//  MealBasicDetailCell.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit
import Kingfisher

class MealBasicDetailCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var placeholderImage: UIImage = {
        return UIImage(systemName: "fork.knife")!
            .withRenderingMode(.alwaysTemplate)
            .withTintColor(.lightGray)
    }()
    
    var onImageTap: ((_ sender: UIButton) -> Void)?

    // MARK: - Outlets
    
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var thumbnailImageView: UIButton!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var areaLabel: UILabel!
    @IBOutlet weak private var instructionsLabel: UILabel!
    @IBOutlet weak private var tagsLabel: UILabel!
    @IBOutlet weak private var youtubeButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 7
        containerView.clipsToBounds = true
    }
    
    // MARK: - Actions
    
    @IBAction private func showImage(_ sender: UIButton) {
        onImageTap?(sender)
    }
    
    @IBAction private func openLink(_ sender: UIButton) {
        if let title = sender.titleLabel?.text,
           let url = URL(string: title),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Functionalities
    
    internal func configure(with meal: Meal) {
        nameLabel.text = meal.name
        categoryLabel.text = meal.category
        areaLabel.text = meal.area
        instructionsLabel.text = meal.instructions
        tagsLabel.text = meal.tags
        
        if let youtube = meal.youtube {
            youtubeButton.setTitle(youtube, for: .normal)
            youtubeButton.isHidden = false
        } else {
            youtubeButton.isHidden = true
        }
        
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
