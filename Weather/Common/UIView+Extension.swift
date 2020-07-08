//
//  UIView+Extension.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func layoutPinToSuperviewMargins(top: Bool = true,
                                     leading: Bool = true,
                                     bottom: Bool = true,
                                     trailing: Bool = true,
                                     insets: UIEdgeInsets = UIEdgeInsets.zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if top {
            topAnchor.constraint(equalTo: superview!.layoutMarginsGuide.topAnchor, constant: insets.top).isActive = true
        }
        if leading {
            leadingAnchor.constraint(equalTo: superview!.layoutMarginsGuide.leadingAnchor, constant: insets.left).isActive = true
        }
        if bottom {
            bottomAnchor.constraint(equalTo: superview!.layoutMarginsGuide.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if trailing {
            trailingAnchor.constraint(equalTo: superview!.layoutMarginsGuide.trailingAnchor, constant: -insets.right).isActive = true
        }
    }
    
    func layoutPinToSuperviewCenter(offset: CGPoint = CGPoint.zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: superview!.centerXAnchor, constant: offset.x).isActive = true
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor, constant: offset.y).isActive = true
    }
    
    func layoutPinToSuperviewEdges(top: Bool = true, leading: Bool = true, bottom: Bool = true, trailing: Bool = true, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if top {
            topAnchor.constraint(equalTo: superview!.topAnchor, constant: insets.top).isActive = true
        }
        if leading {
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: insets.left).isActive = true
        }
        if bottom {
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if trailing {
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -insets.right).isActive = true
        }
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 1.0, y: 0.2)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

