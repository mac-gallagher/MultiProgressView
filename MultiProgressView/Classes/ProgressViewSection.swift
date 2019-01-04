//
//  MGBarView.swift
//  MultiProgressView
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

open class ProgressViewSection: UIView {
    public var titleLabel: UILabel? {
        return label
    }
    
    private var label: UILabel?

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
    
    public var imageView: UIImageView? {
        return sectionImageView
    }

    private var sectionImageView: UIImageView?
    
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
        clipsToBounds = true
    }
    
    private var labelConstraints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.deactivate(oldValue)
            NSLayoutConstraint.activate(labelConstraints)
        }
    }
    
    private var imageViewConstaints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.deactivate(oldValue)
            NSLayoutConstraint.activate(imageViewConstaints)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        labelConstraints = label?.anchorToSuperview(withAlignment: titleAlignment, insets: titleEdgeInsets) ?? []
        imageViewConstaints = sectionImageView?.anchorToSuperview() ?? []
        
        if let imageView = sectionImageView {
            sendSubviewToBack(imageView)
        }
    }
    
    public func setTitle(_ title: String?) {
        createTitleLabelIfNeeded()
        label?.text = title
    }
    
    public func setAttributedTitle(_ title: NSAttributedString?) {
        createTitleLabelIfNeeded()
        label?.attributedText = title
    }
    
    public func setImage(_ image: UIImage?) {
        guard let image = image else { return }
        createImageViewIfNeeded()
        sectionImageView?.image = image
    }
    
    private func createTitleLabelIfNeeded() {
        guard titleLabel == nil else { return }
        let title = UILabel()
        addSubview(title)
        label = title
    }
    
    private func createImageViewIfNeeded() {
        guard imageView == nil else { return }
        let iv = UIImageView()
        addSubview(iv)
        sectionImageView = iv
    }
}
