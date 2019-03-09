//
//  ProgressViewSection.swift
//  MultiProgressView
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

open class ProgressViewSection: UIView {
    public var titleLabel: UILabel {
        return sectionTitleLabel
    }
    
    private var sectionTitleLabel: UILabel = UILabel()
    
    public var titleEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var titleAlignment: AlignmentType = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var imageView: UIImageView {
        return sectionImageView
    }
    
    private var sectionImageView: UIImageView = UIImageView()
    
    private let layoutCalculator: LayoutCalculatable = LayoutCalculator.shared
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = .black
        layer.masksToBounds = true
        addSubview(sectionImageView)
        addSubview(sectionTitleLabel)
    }
    
    private var labelConstraints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.deactivate(oldValue)
            NSLayoutConstraint.activate(labelConstraints)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        labelConstraints = sectionTitleLabel.layout(withAlignment: titleAlignment,
                                                    insets: titleEdgeInsets)
        sectionImageView.frame = layoutCalculator.sectionImageViewFrame(forSection: self)
        sendSubviewToBack(sectionImageView)
    }
    
    public func setTitle(_ title: String?) {
        sectionTitleLabel.text = title
    }
    
    public func setAttributedTitle(_ title: NSAttributedString?) {
        sectionTitleLabel.attributedText = title
    }
    
    public func setImage(_ image: UIImage?) {
        sectionImageView.image = image
    }
}
