//
//  BackgroundView.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

class BackgroundView: UIView {

    // MARK: - UI Components
    
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.tintColor = .placeholderText
        return imageView
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .placeholderText
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 24
        
        view.addArrangedSubview(iconView)
        view.addArrangedSubview(messageLabel)
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(icon: UIImage? = nil, message: String) {
        super.init(frame: .zero)
        
        setupComponents()
        set(icon: icon, message: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponents() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -24),
        ])
    }
    
    // MARK: - Functionalitities
    
    private func set(icon: UIImage? = nil, message: String) {
        iconView.image = icon
        messageLabel.text = message
    }
    
}
