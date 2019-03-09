//
//  UIView+Extensions.swift
//  MultiProgressView
//
//  Created by Mac Gallagher on 3/7/19.
//

import UIKit

extension UIView {
    func layout(withAlignment alignment: AlignmentType, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let superview = superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        switch alignment {
        case .bottom:
            constraints.append(bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom))
            constraints.append(centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: insets.left - insets.right))
            
        case .bottomLeft:
            constraints.append(bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom))
            constraints.append(leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left))
            
        case .bottomRight:
            constraints.append(bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom))
            constraints.append(rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right))
            
        case .center:
            constraints.append(centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: insets.left - insets.right))
            constraints.append(centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: insets.top - insets.bottom))
            
        case .left:
            constraints.append(leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left))
            constraints.append(centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: insets.top - insets.bottom))
            
        case .right:
            constraints.append(rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right))
            constraints.append(centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: insets.top - insets.bottom))
            
        case .top:
            constraints.append(topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top))
            constraints.append(centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: insets.left - insets.right))
            
        case .topLeft:
            constraints.append(topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top))
            constraints.append(leftAnchor.constraint(equalTo: superview.leftAnchor,  constant: insets.left))
            
        case .topRight:
            constraints.append(topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top))
            constraints.append(rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right))
        }
        
        constraints.forEach { $0.isActive = true }
        
        return constraints
    }
}
