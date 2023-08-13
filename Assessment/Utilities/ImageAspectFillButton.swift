//
//  ImageAspectFillButton.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

class ImageAspectFillButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.contentMode = .scaleAspectFill
    }
    
}
