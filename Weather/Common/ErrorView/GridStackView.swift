//
//  GridStackView.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/08.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

typealias ArrangedViews = (left: UIView, right: UIView)

class GridStackView: UIView {
    
    
    let containerStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: - View Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
}

extension GridStackView {
    
    private func setupView() {
        
        self.addSubview(containerStackView)
        containerStackView.topAnchor.constraint(equalTo:  self.layoutMarginsGuide.topAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo:  self.layoutMarginsGuide.bottomAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo:  self.layoutMarginsGuide.leadingAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo:  self.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    func addArranged(subviews: [ArrangedViews]) {
        
        for subview in subviews {
            
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .leading
            stackView.distribution = .fillEqually
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
                
            stackView.addArrangedSubview(subview.left)
            stackView.addArrangedSubview(subview.right)
            
            containerStackView.addArrangedSubview(stackView)
        }
    }
}
