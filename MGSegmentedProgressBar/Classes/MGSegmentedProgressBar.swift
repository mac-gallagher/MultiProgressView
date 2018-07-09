//
//  MGSegmentedProgressBar.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

public enum MGLineCap {
    case round, butt, square
}

open class MGSegmentedProgressBar: UIView {
    
    //MARK: - Variables
    
    public var dataSource: MGSegmentedProgressBarDataSource? {
        didSet {
            reloadData()
        }
    }
    
    private let trackView: UIView = {
        let track = UIView()
        track.clipsToBounds = true
        return track
    }()
    
    private var trackViewConstriants = [NSLayoutConstraint]()
    
    public var trackInset: CGFloat = 0 {
        didSet {
            layoutTrackView()
        }
    }
    
    public var trackBackgroundColor: UIColor? {
        didSet {
            trackView.backgroundColor = trackBackgroundColor
        }
    }
    
    public private(set) var titleLabel: UILabel?
    private var labelConstraints = [NSLayoutConstraint]()
    
    public var labelEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var labelAlignment: MGLabelAlignment = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var lineCap: MGLineCap = .round {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var bars: [MGBarView] = []
    private var barConstraintsForSection: [Int: [NSLayoutConstraint]] = [:]
    private var currentStepForSection: [Int: Int] = [:]
    private var numberOfStepsForSection: [Int: Int] = [:]
    private var totalSteps = 0
    
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
        clipsToBounds = true
        addSubview(trackView)
    }
    
    //MARK: - Layout

    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutTrackView()
        layoutTrackTitleLabel()
        for index in 0..<bars.count {
            layoutBar(bars[index], section: index)
        }
    }
    
    private func layoutTrackView() {
        NSLayoutConstraint.deactivate(trackViewConstriants)
        if lineCap == .butt {
            trackViewConstriants = trackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: trackInset, bottomConstant: trackInset)
        } else {
            trackViewConstriants = trackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: trackInset, leftConstant: trackInset, bottomConstant: trackInset, rightConstant: trackInset)
        }
    }
    
    private func layoutTrackTitleLabel() {
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
    }
    
    private func layoutBar(_ bar: MGBarView, section: Int) {
        if barConstraintsForSection[section] != nil {
            NSLayoutConstraint.deactivate(barConstraintsForSection[section]!)
        }
        
        if section == 0 {
            barConstraintsForSection[section] = bar.anchor(top: trackView.topAnchor, left: trackView.leftAnchor, bottom: trackView.bottomAnchor)
        } else {
            barConstraintsForSection[section] = bar.anchor(top: trackView.topAnchor, left: bars[section - 1].rightAnchor, bottom: trackView.bottomAnchor)
        }
        
        if let steps = currentStepForSection[section], totalSteps != 0 {
            let widthMultiplier = CGFloat(steps) / CGFloat(totalSteps)
            barConstraintsForSection[section]?.append(bar.widthAnchor.constraint(equalTo: trackView.widthAnchor, multiplier: widthMultiplier))
        }
        
        NSLayoutConstraint.activate(barConstraintsForSection[section]!)
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        switch lineCap {
        case .round:
            layer.cornerRadius = bounds.height / 2
            trackView.layer.cornerRadius = trackView.bounds.height / 2
        case .butt, .square:
            layer.cornerRadius = 0
            trackView.layer.cornerRadius = 0
        }
    }
    
    //MARK: - Setters/Getters
    
    open func setTitle(_ title: String?) {
        if titleLabel == nil {
            titleLabel?.removeFromSuperview()
            titleLabel = UILabel()
            trackView.insertSubview(titleLabel!, at: 0)
        }
        titleLabel?.text = title
        layoutTrackTitleLabel()
    }
    
    open func setAttributedTitle(_ title: NSAttributedString?) {
        if titleLabel == nil {
            titleLabel?.removeFromSuperview()
            titleLabel = UILabel()
            trackView.insertSubview(titleLabel!, at: 0)
        }
        titleLabel?.attributedText = title
        layoutTrackTitleLabel()
    }
    
    //MARK: - Main Methods
    
    open func setProgress(section: Int, steps: Int) {
        if section < 0 || section >= bars.count { return }
        if steps <= 0 {
            currentStepForSection[section] = 0
        } else {
            currentStepForSection[section] = min(steps, numberOfStepsForSection[section] ?? 0)
        }
        layoutBar(bars[section], section: section)
    }
    
    open func advance(section: Int, by numberOfSteps: Int = 1) {
        setProgress(section: section, steps: (currentStepForSection[section] ?? 0) + numberOfSteps)
    }
    
    open func reset() {
        for section in 0..<bars.count {
            setProgress(section: section, steps: 0)
        }
    }

    //MARK: - Data Source
    
    public func reloadData() {
        guard let dataSource = dataSource else { return }
        
        for bar in bars {
            bar.removeFromSuperview()
        }
        bars = []
        numberOfStepsForSection = [:]
        totalSteps = 0
        
        for section in 0..<dataSource.numberOfSections(in: self) {
            let bar = dataSource.progressBar(self, barForSection: section)
            
            bar.removeFromSuperview()
            trackView.addSubview(bar)
            bars.append(bar)
            
            currentStepForSection[section] = 0
            let steps = dataSource.progressBar(self, numberOfStepsInSection: section)
            numberOfStepsForSection[section] = steps
            totalSteps += steps
            
            reloadBarTitle(bar, section: section)
        }

        setNeedsLayout()
    }
    
    private func reloadBarTitle(_ bar: MGBarView, section: Int) {
        guard let dataSource = dataSource else { return }
        
        //reload title
        let attributedTitle = dataSource.progressBar(self, attributedTitleForSection: section)
        if attributedTitle != nil {
            bar.setAttributedTitle(attributedTitle)
        } else {
            let title = dataSource.progressBar(self, titleForSection: section)
            bar.setTitle(title)
        }
        
        //reload title insets
        let insets = dataSource.progressBar(self, titleInsetsForSection: section)
        bar.labelEdgeInsets = insets
        
        //reload title alignment
        let alignment = dataSource.progressBar(self, titleAlignmentForSection: section)
        bar.labelAlignment = alignment
    }
    
}







