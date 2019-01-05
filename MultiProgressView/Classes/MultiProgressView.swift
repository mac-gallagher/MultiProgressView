//
//  MGSegmentedProgressBar.swift
//  MultiProgressView
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

open class MultiProgressView: UIView {
    public var dataSource: MultiProgressViewDataSource? {
        didSet {
            reloadData()
        }
    }
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    public var borderColor: UIColor? = .black {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    public var trackInset: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var trackBackgroundColor: UIColor? = .white {
        didSet {
            track.backgroundColor = trackBackgroundColor
        }
    }
    
    public var trackBorderColor: UIColor? = .black {
        didSet {
            track.layer.borderColor = trackBorderColor?.cgColor
        }
    }
    
    public var trackBorderWidth: CGFloat = 0 {
        didSet {
            track.layer.borderWidth = trackBorderWidth
        }
    }
    
    public var trackTitleLabel: UILabel? {
        return label
    }
    
    private var label: UILabel?
    
    public var trackTitleEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var trackTitleAlignment: AlignmentType = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var trackImageView: UIImageView? {
        return imageView
    }
    
    private var imageView: UIImageView?
    
    public var lineCap: LineCapType = .square {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var totalProgress: Float {
        return currentProgress.reduce(0) { $0 + $1 }
    }
    
    private let track: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private var progressBarSections: [ProgressViewSection] = []
    private var numberOfSections: Int = 0
    private var currentProgress: [Float] = []
    
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
        backgroundColor = .white
        clipsToBounds = true
        addSubview(track)
    }
    
    //MARK: - Layout
    
    private var trackConstraints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.deactivate(oldValue)
            NSLayoutConstraint.activate(trackConstraints)
        }
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
    
    private var barSectionConstraints = [[NSLayoutConstraint]]()
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        trackConstraints = track.anchorToSuperview(withCapType: lineCap, padding: trackInset)
        labelConstraints = label?.anchorToSuperview(withAlignment: trackTitleAlignment, insets: trackTitleEdgeInsets) ?? []
        imageViewConstaints = imageView?.anchorToSuperview() ?? []
        
        for (index, bar) in progressBarSections.enumerated() {
            layoutBar(bar, section: index)
            track.bringSubviewToFront(bar)
        }
        
        if let imageView = imageView {
            track.sendSubviewToBack(imageView)
        }

        applyCornerRadius()
    }

    private func layoutBar(_ bar: ProgressViewSection, section: Int) {
        NSLayoutConstraint.deactivate(barSectionConstraints[section])
        var barConstraints = [NSLayoutConstraint]()
        
        if section == 0 {
            barConstraints.append(contentsOf: bar.anchor(top: track.topAnchor, left: track.leftAnchor, bottom: track.bottomAnchor))
        } else {
            barConstraints.append(contentsOf: bar.anchor(top: track.topAnchor, left: progressBarSections[section - 1].rightAnchor, bottom: track.bottomAnchor))
        }
        
        let widthConstraint = bar.widthAnchor.constraint(equalTo: track.widthAnchor, multiplier: CGFloat(currentProgress[section]))
        barConstraints.append(widthConstraint)
        
        NSLayoutConstraint.activate(barConstraints)
        barSectionConstraints[section] = barConstraints
    }
    
    private func applyCornerRadius() {
        let cornerRadiusFactor: CGFloat = cornerRadius / bounds.height
        switch lineCap {
        case .round:
            layer.cornerRadius = cornerRadius == 0 ? bounds.height / 2 : cornerRadius
            track.layer.cornerRadius = cornerRadius == 0 ? track.bounds.height / 2 : cornerRadiusFactor * track.bounds.height
        case .butt, .square:
            layer.cornerRadius = 0
            track.layer.cornerRadius = 0
        }
    }
    
    //MARK: - Data Source
    
    public func reloadData() {
        guard let dataSource = dataSource else { return }
        numberOfSections = dataSource.numberOfSections(in: self)
        
        progressBarSections.forEach({ $0.removeFromSuperview() })
        progressBarSections.removeAll()
        currentProgress.removeAll()
        barSectionConstraints.removeAll()

        for index in 0..<numberOfSections {
            configureSection(index)
        }
    }
    
    private func configureSection(_ section: Int) {
        guard let dataSource = dataSource else { return }
        let bar = dataSource.progressView(self, viewForSection: section)
        progressBarSections.insert(bar, at: section)
        track.addSubview(bar)
        currentProgress.insert(0, at: section)
        barSectionConstraints.insert([], at: section)
    }
    
    //MARK: - Main Methods
    
    public func setTitle(_ title: String?) {
        createTrackTitleLabelIfNeeded()
        label?.text = title
    }
    
    public func setAttributedTitle(_ title: NSAttributedString?) {
        createTrackTitleLabelIfNeeded()
        label?.attributedText = title
    }
    
    private func createTrackTitleLabelIfNeeded() {
        guard trackTitleLabel == nil else { return }
        let title = UILabel()
        track.addSubview(title)
        label = title
    }
    
    public func setTrackImage(_ image: UIImage?) {
        guard let image = image else { return }
        createTrackImageViewIfNeeded()
        imageView?.image = image
    }
    
    private func createTrackImageViewIfNeeded() {
        guard imageView == nil else { return }
        let iv = UIImageView()
        track.addSubview(iv)
        imageView = iv
    }
    
    public func progress(forSection section: Int) -> Float {
        return currentProgress[section]
    }
    
    public func setProgress(section: Int, to progress: Float) {
        currentProgress[section] = max(0, min(progress, 1 - totalProgress + currentProgress[section]))
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    public func resetProgress() {
        for section in 0..<progressBarSections.count {
            setProgress(section: section, to: 0)
        }
    }
}
