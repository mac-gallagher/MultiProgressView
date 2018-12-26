//
//  MGBarView.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

open class ProgressBarSection: UIView {
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
    }
    
    private var labelConstraints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.deactivate(oldValue)
            NSLayoutConstraint.activate(labelConstraints)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        labelConstraints = titleLabel?.anchorToSuperview(withAlignment: titleAlignment, insets: titleEdgeInsets) ?? []
    }
    
    public func setTitle(_ title: String?) {
        createTitleLabelIfNeeded()
        label?.text = title
        setNeedsLayout()
    }
    
    public func setAttributedTitle(_ title: NSAttributedString?) {
        createTitleLabelIfNeeded()
        label?.attributedText = title
        setNeedsLayout()
    }
    
    private func createTitleLabelIfNeeded() {
        guard titleLabel == nil else { return }
        let title = UILabel()
        addSubview(title)
        label = title
    }
}
