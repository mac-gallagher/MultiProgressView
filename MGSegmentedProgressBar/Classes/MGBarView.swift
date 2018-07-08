//
//  MGBarView.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

open class MGBarView: UIView {
    
    //MARK: - Variables
    
    public var titleLabel: UILabel?
    
    public var labelEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            layoutMargins = labelEdgeInsets
            setNeedsLayout()
        }
    }
    
    public var labelHorizontalAlignment: MGHorizontalAlignment = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var labelVerticalAlignment: MGVerticalAlignment = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    //MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        clipsToBounds  = true
        backgroundColor = .black
    }
    
    //MARK: - Layout
    
    private var labelConstraints = [NSLayoutConstraint]()
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        guard let label = titleLabel else { return }
        
        NSLayoutConstraint.deactivate(labelConstraints)
        label.translatesAutoresizingMaskIntoConstraints = false
        labelConstraints = []
        
        switch labelHorizontalAlignment {
        case .left:
            labelConstraints.append(label.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor))
            label.textAlignment = .left
        case .center:
            labelConstraints.append(label.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor))
            label.textAlignment = .center
        case .right:
            labelConstraints.append(label.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor))
            label.textAlignment = .right
        }
        
        switch labelVerticalAlignment {
        case .top:
            labelConstraints.append(label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor))
        case .center:
            labelConstraints.append(label.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor))
        case .bottom:
            labelConstraints.append(label.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor))
        }
        
        NSLayoutConstraint.activate(labelConstraints)
        
        if CGRect(origin: .zero, size: layoutMarginsGuide.layoutFrame.size).contains(label.bounds) {
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
    
    //MARK: - Setters/Getters
    
    open func setTitle(_ title: String?) {
        if titleLabel == nil {
            titleLabel?.removeFromSuperview()
            titleLabel = UILabel()
            addSubview(titleLabel!)
        }
        titleLabel?.text = title
        setNeedsLayout()
    }
    
    open func setAttributedTitle(_ title: NSAttributedString?) {
        if titleLabel == nil {
            titleLabel?.removeFromSuperview()
            titleLabel = UILabel()
            addSubview(titleLabel!)
        }
        titleLabel?.attributedText = title
        setNeedsLayout()
    }
    
}



