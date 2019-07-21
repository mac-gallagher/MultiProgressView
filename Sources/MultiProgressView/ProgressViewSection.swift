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
    
    private var layoutProvider: LayoutProvidable.Type = LayoutProvider.self
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    convenience init(layoutProvider: LayoutProvidable.Type) {
        self.init(frame: .zero)
        self.layoutProvider = layoutProvider
    }
    
    private func initialize() {
        backgroundColor = .black
        layer.masksToBounds = true
        addSubview(sectionImageView)
        addSubview(sectionTitleLabel)
    }
    
    // MARK: - Layout
    
    var labelConstraints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.deactivate(oldValue)
            NSLayoutConstraint.activate(labelConstraints)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        labelConstraints = layoutProvider.anchorToSuperview(sectionTitleLabel,
                                                            withAlignment: titleAlignment,
                                                            insets: titleEdgeInsets)
        sectionImageView.frame = layoutProvider.sectionImageViewFrame(self)
        sendSubviewToBack(sectionImageView)
    }
    
    // MARK: - Main Methods
    
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
