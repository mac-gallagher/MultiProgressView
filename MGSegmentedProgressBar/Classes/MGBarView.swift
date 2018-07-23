//
//  MGBarView.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

open class MGBarView: UIView {
    
    public private(set) var titleLabel: UILabel?
    private var labelConstraints = [NSLayoutConstraint]()

    public var labelEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            layoutMargins = labelEdgeInsets
            setNeedsLayout()
        }
    }

    public var labelAlignment: MGLabelAlignment = .center {
        didSet { setNeedsLayout() }
    }
    
    public var titleAlwaysVisible: Bool = false
    
    //MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit() {
        clipsToBounds  = true
        backgroundColor = .lightGray
        labelEdgeInsets = .zero
    }
    
    //MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
    }
    
    private func layoutTitleLabel() {
        guard let titleLabel = titleLabel else { return }
        
        NSLayoutConstraint.deactivate(labelConstraints)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        labelConstraints = []
        
        switch labelAlignment {
        case .left:
            labelConstraints.append(titleLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor))
            labelConstraints.append(titleLabel.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor))
        case .topLeft:
            labelConstraints.append(titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor))
            labelConstraints.append(titleLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor))
        case .top:
            labelConstraints.append(titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor))
            labelConstraints.append(titleLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor))
        case .topRight:
            labelConstraints.append(titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor))
            labelConstraints.append(titleLabel.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor))
        case .right:
            labelConstraints.append(titleLabel.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor))
            labelConstraints.append(titleLabel.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor))
        case .bottomRight:
            labelConstraints.append(titleLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor))
            labelConstraints.append(titleLabel.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor))
        case .bottom:
            labelConstraints.append(titleLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor))
            labelConstraints.append(titleLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor))
        case .bottomLeft:
            labelConstraints.append(titleLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor))
            labelConstraints.append(titleLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor))
        case .center:
            labelConstraints.append(titleLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor))
            labelConstraints.append(titleLabel.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor))
        }
        
        NSLayoutConstraint.activate(labelConstraints)
        
        if CGRect(origin: .zero, size: layoutMarginsGuide.layoutFrame.size).contains(titleLabel.bounds) || titleAlwaysVisible {
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
    }
    
    //MARK: - Setters/Getters
    
    public func setTitle(_ title: String?) {
        if titleLabel == nil {
            titleLabel = UILabel()
            addSubview(titleLabel!)
        }
        titleLabel?.text = title
        setNeedsLayout()
    }
    
    public func setAttributedTitle(_ title: NSAttributedString?) {
        if titleLabel == nil {
            titleLabel = UILabel()
            addSubview(titleLabel!)
        }
        titleLabel?.attributedText = title
        setNeedsLayout()
    }
    
}



