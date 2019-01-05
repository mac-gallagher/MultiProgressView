//
//  UIView+Extensions.swift
//  MultiProgressView
//
//  Created by Mac Gallagher on 7/8/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
        }
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: paddingLeft))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom))
        }
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -paddingRight))
        }
        if width > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    @discardableResult
    func anchorToSuperview() -> [NSLayoutConstraint] {
        guard let superview = superview else { return [] }
        return anchor(top: superview.topAnchor, left: superview.leftAnchor, bottom: superview.bottomAnchor, right: superview.rightAnchor)
    }
    
    @discardableResult
    func anchorToSuperview(withAlignment alignment: AlignmentType, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
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
        
        constraints.forEach({$0.isActive = true})
        
        return constraints
    }
    
    func anchorToSuperview(withCapType type: LineCapType, padding: CGFloat) -> [NSLayoutConstraint] {
        guard let superview = superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        switch type {
        case .butt:
            constraints = anchor(top: superview.topAnchor, left: superview.leftAnchor, bottom: superview.bottomAnchor, right: superview.rightAnchor, paddingTop: padding, paddingBottom: padding)
        case .round, .square:
            constraints = anchor(top: superview.topAnchor, left: superview.leftAnchor, bottom: superview.bottomAnchor, right: superview.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding)
        }
        
        constraints.forEach({$0.isActive = true})
        
        return constraints
    }
}
