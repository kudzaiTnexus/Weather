//
//  ErrorViewController.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//


import UIKit

class ErrorViewController: UIViewController {
    
    private let errorAvatar: UIImageView = {
        let imageView = UIImageView()
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "exclamationmark.icloud")
        } else {
            imageView.image = UIImage(named: "cloud")
        }
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let errorLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .red
        label.text = "Something went wrong"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    private let retryButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .blue
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "gobackward"), for: .normal)
        } else {
            button.setImage(UIImage(named: "backArrow"), for: .normal)
        }
        button.imageView?.contentMode = .scaleAspectFill
        button.setTitle(NSLocalizedString("error.retry", comment: ""), for: .normal)
        let imageSize: CGSize = button.imageView!.image!.size
        button.titleEdgeInsets = UIEdgeInsets(top: 26,
                                              left: -imageSize.width,
                                              bottom: 0,
                                              right: 0);
        let labelString = NSString(string: button.titleLabel?.text ?? "")
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: button.titleLabel?.font as Any])
        button.imageEdgeInsets = UIEdgeInsets(top: -35,
                                              left: 0,
                                              bottom: 0,
                                              right: -(titleSize.width+5))
        
        button.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let verticalStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0
        
        return stackView
    }()
    
    private let stackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 50
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    weak var delegate: RetryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    @objc func retryTapped() {
        delegate?.onRetryTap()
    }
}

extension ErrorViewController {
    
    func setupView() {
        
        self.view.backgroundColor = .white
        
        verticalStackView.addArrangedSubview(errorAvatar)
        verticalStackView.addArrangedSubview(errorLabel)
        
        stackView.addArrangedSubview(verticalStackView)
        stackView.addArrangedSubview(retryButton)
        
        self.view.addSubview(stackView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        
        errorAvatar.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureView(with errorTitle: String) {
        errorLabel.text = errorTitle
    }
}
