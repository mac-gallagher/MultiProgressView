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
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var barInset: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var barBackgroundColor: UIColor? = .white {
        didSet {
            progressBar.backgroundColor = barBackgroundColor
        }
    }
    
    public var barBorderColor: UIColor? = .black {
        didSet {
            progressBar.layer.borderColor = barBorderColor?.cgColor
        }
    }
    
    public var barBorderWidth: CGFloat = 0 {
        didSet {
            progressBar.layer.borderWidth = barBorderWidth
        }
    }
    
    public var barTitleLabel: UILabel? {
        return label
    }
    
    private var label: UILabel?
    
    public var barTitleEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var barTitleAlignment: AlignmentType = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var lineCap: LineCapType = .round {
        didSet {
            setNeedsLayout()
        }
    }
    
    private let progressBar: UIView = {
        let bar = UIView()
        bar.clipsToBounds = true
        return bar
    }()
    
    private var numberOfSections: Int = 0
    private var currentSteps: [Int] = []
    private var totalSteps: Int = 0
    private var progressBarSections: [ProgressBarSection] = []
    
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
        addSubview(progressBar)
    }
    
    //MARK: - Layout
    
    private var progressBarConstraints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.deactivate(oldValue)
            NSLayoutConstraint.activate(progressBarConstraints)
        }
    }
    
    private var labelConstraints = [NSLayoutConstraint]() {
        didSet {
            NSLayoutConstraint.deactivate(oldValue)
            NSLayoutConstraint.activate(labelConstraints)
        }
    }
    
    //just make bar constraints
//    private var barWidthConstraints = [NSLayoutConstraint]() {
//        didSet {
//            NSLayoutConstraint.activate(barWidthConstraints)
//            NSLayoutConstraint.deactivate(oldValue)
//        }
//    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        progressBarConstraints = progressBar.anchorToSuperview(withCapType: lineCap, padding: barInset)
        labelConstraints = barTitleLabel?.anchorToSuperview(withAlignment: barTitleAlignment, insets: barTitleEdgeInsets) ?? []
//        for (section, bar) in sections.enumerated() {
//            layoutBar(bar, section: section)
//        }
        applyCornerRadius()
    }

//    private func layoutBar(_ bar: ProgressBarSection, section: Int) {
//        guard totalSteps != 0 else { return }
//        NSLayoutConstraint.deactivate([barWidthConstraints[section]])
//        let widthMultiplier = CGFloat(currentSteps[section]) / CGFloat(totalSteps)
//        barWidthConstraints[section] = bar.widthAnchor.constraint(equalTo: trackView.widthAnchor, multiplier: widthMultiplier)
//        NSLayoutConstraint.activate([barWidthConstraints[section]])
//    }
//
  
    private func constraintsForBar(index: Int) {
//        let currentStepsTotal = currentSteps.reduce(0, { $0 + $1 })
//        let newCurrentStepsTotal = (currentStepsTotal - currentSteps[section] + steps)
    }
    
    private func applyCornerRadius() {
        switch lineCap {
        case .round:
            layer.cornerRadius = cornerRadius == 0 ? bounds.height / 2 : cornerRadius
            progressBar.layer.cornerRadius = cornerRadius == 0 ? bounds.height / 2 : cornerRadius
        case .butt:
            layer.cornerRadius = cornerRadius
            progressBar.layer.cornerRadius = 0
        case .square:
            layer.cornerRadius = 0
            progressBar.layer.cornerRadius = 0
        }
    }
    
    //MARK: - Data Source
    
    public func reloadData() {
        guard let dataSource = dataSource else { return }
        numberOfSections = dataSource.numberOfSections(in: self)
        totalSteps = dataSource.numberOfSteps(in: self)
        
        progressBarSections.forEach({ $0.removeFromSuperview() })
        progressBarSections.removeAll()
        currentSteps.removeAll()
//        barWidthConstraints = []

        for section in 0..<numberOfSections {
            let bar = dataSource.progressBar(self, barForSection: section)
            progressBarSections.append(bar)
            currentSteps.append(0)
            progressBar.addSubview(bar)
//            barWidthConstraints.append(NSLayoutConstraint())
//            if section == 0 {
//                _ = bar.anchor(top: trackView.topAnchor, left: trackView.leftAnchor, bottom: trackView.bottomAnchor)
//            } else {
//                _ = bar.anchor(top: trackView.topAnchor, left: sections[section - 1].rightAnchor, bottom: trackView.bottomAnchor)
//            }
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
        guard barTitleLabel == nil else { return }
        let title = UILabel()
        progressBar.insertSubview(title, at: 0)
        label = title
        setNeedsLayout()
    }
    
    public func progress(forSection section: Int) -> Int {
        return currentSteps[section]
    }
    
    public func setProgress(forSection section: Int, steps: Int) {
        let currentStepsSum = currentSteps.reduce(0, { $0 + $1 })
        let newStepsSum = currentStepsSum + (steps - currentSteps[section])
        let stepsToAdd = min(0, totalSteps - newStepsSum)
        currentSteps[section] = max(0, steps + stepsToAdd)
        setNeedsLayout()
    }
    
    public func advance(section: Int, by numberOfSteps: Int = 1) {
        setProgress(forSection: section, steps: currentSteps[section] + numberOfSteps)
    }

    public func resetProgress() {
        for section in 0..<progressBarSections.count {
            setProgress(forSection: section, steps: 0)
        }
    }
}
