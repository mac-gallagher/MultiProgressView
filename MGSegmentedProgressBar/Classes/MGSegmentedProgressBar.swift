//
//  MGSegmentedProgressBar.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

open class MGSegmentedProgressBar: UIView {
    public var dataSource: MGSegmentedProgressBarDataSource? {
        didSet {
            reloadData()
        }
    }
    public var trackPadding: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var trackBackgroundColor: UIColor? {
        didSet {
            trackView.backgroundColor = trackBackgroundColor
        }
    }
    
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
    
    public var lineCap: LineCapType = .round {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private let trackView: UIView = {
        let track = UIView()
        track.clipsToBounds = true
        return track
    }()
    
    private var numberOfSections: Int = 0
    private var currentSteps: [Int] = []
    private var totalSteps: Int = 0
    private var maxSteps: [Int] = []
    private var sections: [ProgressBarSection] = []
    
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
        clipsToBounds = true
        addSubview(trackView)
    }
    
    //MARK: - Layout
    
    private var trackViewConstraints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.activate(trackViewConstraints)
            NSLayoutConstraint.deactivate(oldValue)
        }
    }
    
    private var labelConstraints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.activate(labelConstraints)
            NSLayoutConstraint.deactivate(oldValue)
        }
    }
    
    //just make bar constraints
    private var barWidthConstraints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.activate(barWidthConstraints)
            NSLayoutConstraint.deactivate(oldValue)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutTrackView()
        labelConstraints = titleLabel?.anchorToSuperview(withAlignment: titleAlignment) ?? []
        for (section, bar) in sections.enumerated() {
            layoutBar(bar, section: section)
        }
    }
    
    private func layoutTrackView() {
        if lineCap == .butt {
            trackViewConstraints = trackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: trackPadding, paddingBottom: trackPadding)
        } else {
            trackViewConstraints = trackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: trackPadding, paddingLeft: trackPadding, paddingBottom: trackPadding, paddingRight: trackPadding)
        }
    }

    private func layoutBar(_ bar: ProgressBarSection, section: Int) {
        guard totalSteps != 0 else { return }
        NSLayoutConstraint.deactivate([barWidthConstraints[section]])
        let widthMultiplier = CGFloat(currentSteps[section]) / CGFloat(totalSteps)
        barWidthConstraints[section] = bar.widthAnchor.constraint(equalTo: trackView.widthAnchor, multiplier: widthMultiplier)
        NSLayoutConstraint.activate([barWidthConstraints[section]])
    }
    
//    open override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        switch lineCap {
//        case .round:
//            layer.cornerRadius = bounds.height / 2
//            trackView.layer.cornerRadius = trackView.bounds.height / 2
//        case .butt, .square:
//            layer.cornerRadius = 0
//            trackView.layer.cornerRadius = 0
//        }
//    }
    
    //MARK: - Data Source
    
    public func reloadData() {
        guard let dataSource = dataSource else { return }
        sections.forEach({ $0.removeFromSuperview() })
        sections = []
        currentSteps = []
        barWidthConstraints = []
        numberOfSections = dataSource.numberOfSections(in: self)
        totalSteps = dataSource.numberOfSteps(in: self)
        
        for section in 0..<numberOfSections {
            let bar = dataSource.progressBar(self, barForSection: section)
            sections.append(bar)
            currentSteps.append(0)
            trackView.addSubview(bar)
            barWidthConstraints.append(NSLayoutConstraint())
            if section == 0 {
                _ = bar.anchor(top: trackView.topAnchor, left: trackView.leftAnchor, bottom: trackView.bottomAnchor)
            } else {
                _ = bar.anchor(top: trackView.topAnchor, left: sections[section - 1].rightAnchor, bottom: trackView.bottomAnchor)
            }
        }
    }
    
    //MARK: - Main Methods
    
    public func setTitle(_ title: String?) {
        createTitleLabelIfNeeded()
        label?.text = title
    }
    
    public func setAttributedTitle(_ title: NSAttributedString?) {
        createTitleLabelIfNeeded()
        label?.attributedText = title
    }
    
    private func createTitleLabelIfNeeded() {
        guard titleLabel == nil else { return }
        let title = UILabel()
        trackView.insertSubview(title, at: 0)
        label = title
        setNeedsLayout()
    }
    
    public func setProgress(section: Int, steps: Int) {
        let currentStepsTotal = currentSteps.reduce(0, { $0 + $1 })
        let newCurrentStepsTotal = (currentStepsTotal - currentSteps[section] + steps)
        let overflow = min(0, totalSteps - newCurrentStepsTotal)
        currentSteps[section] = min(max(0, steps + overflow), maxSteps[section])
        layoutBar(sections[section], section: section)
        layoutIfNeeded()
    }
    
    public func advance(section: Int, by numberOfSteps: Int = 1) {
        setProgress(section: section, steps: currentSteps[section] + numberOfSteps)
    }
    
    public func resetProgress() {
        for section in 0..<sections.count {
            setProgress(section: section, steps: 0)
        }
    }
}
