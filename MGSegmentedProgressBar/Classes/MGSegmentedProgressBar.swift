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
    
    public var dataSource: MGSegmentedProgressBarDataSource? {
        didSet { reloadData() }
    }
    
    public var delegate: MGSegmentedProgressBarDelegate? {
        didSet { reloadData() }
    }
    
    private let trackView: UIView = {
        let track = UIView()
        track.clipsToBounds = true
        return track
    }()
    
    private var trackViewConstriants = [NSLayoutConstraint]()
    
    public var trackInset: CGFloat = 0 {
        didSet { layoutTrackView() }
    }
    
    public var trackBackgroundColor: UIColor? {
        didSet {
            trackView.backgroundColor = trackBackgroundColor
        }
    }
    
    public private(set) var titleLabel: UILabel?
    private var labelConstraints = [NSLayoutConstraint]()
    
    public var labelEdgeInsets: UIEdgeInsets = .zero {
        didSet { setNeedsLayout() }
    }

    public var labelAlignment: MGLabelAlignment = .center {
        didSet { setNeedsLayout() }
    }
    
    public var lineCap: MGLineCap = .round {
        didSet { setNeedsDisplay() }
    }
    
    private var numberOfSections: Int = 0
    private var currentSteps: [Int] = []
    private var totalSteps: Int = 0
    private var maxSteps: [Int] = []
    private var bars: [MGBarView] = []
    private var barWidthConstraints: [NSLayoutConstraint] = []
    
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
        for (section, bar) in bars.enumerated() {
            layoutBar(bar, section: section)
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
        if totalSteps != 0 {
            NSLayoutConstraint.deactivate([barWidthConstraints[section]])
            let widthMultiplier = CGFloat(currentSteps[section]) / CGFloat(totalSteps)
            barWidthConstraints[section] = bar.widthAnchor.constraint(equalTo: trackView.widthAnchor, multiplier: widthMultiplier)
            NSLayoutConstraint.activate([barWidthConstraints[section]])
        }
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
    
    //MARK: - Data Source
    
    public func reloadData() {
        guard let dataSource = dataSource else { return }
        
        bars.forEach({ $0.removeFromSuperview() })
        bars = []
        currentSteps = []
        barWidthConstraints = []
        maxSteps = []
        numberOfSections = dataSource.numberOfSections(in: self)
        totalSteps = dataSource.numberOfSteps(in: self)
        
        for section in 0..<numberOfSections {
            let bar = reloadBar(section: section) ?? MGBarView()
            bars.append(bar)
            currentSteps.append(0)
            maxSteps.append(dataSource.progressBar(self, maximumNumberOfStepsForSection: section))
            trackView.addSubview(bar)
            barWidthConstraints.append(NSLayoutConstraint())
            if section == 0 {
                _ = bar.anchor(top: trackView.topAnchor, left: trackView.leftAnchor, bottom: trackView.bottomAnchor)
            } else {
                _ = bar.anchor(top: trackView.topAnchor, left: bars[section - 1].rightAnchor, bottom: trackView.bottomAnchor)
            }
        }
    }
    
    private func reloadBar(section: Int) -> MGBarView? {
        guard let dataSource = dataSource else { return nil }
        let bar = dataSource.progressBar(self, barForSection: section)
        
        bar.setAttributedTitle(dataSource.progressBar(self, attributedTitleForSection: section))
        bar.setTitle(dataSource.progressBar(self, titleForSection: section))
        
        if let delegate = delegate {
            bar.labelEdgeInsets = delegate.progressBar(self, titleInsetsForSection: section)
            bar.labelAlignment = delegate.progressBar(self, titleAlignmentForSection: section)
            bar.titleAlwaysVisible = delegate.progressBar(self, titleAlwaysVisibleForSection: section)
        }
       
        return bar
    }
    
    //MARK: - Setters/Getters
    
    public func setTitle(_ title: String?) {
        if titleLabel == nil {
            titleLabel = UILabel()
            trackView.insertSubview(titleLabel!, at: 0)
        }
        titleLabel?.text = title
        layoutTrackTitleLabel()
    }
    
    public func setAttributedTitle(_ title: NSAttributedString?) {
        if titleLabel == nil {
            titleLabel = UILabel()
            trackView.insertSubview(titleLabel!, at: 0)
        }
        titleLabel?.attributedText = title
        layoutTrackTitleLabel()
    }
    
    //MARK: - Main Methods
    
    public func setProgress(section: Int, steps: Int) {
        if section < 0 || section >= numberOfSections { return }
        let currentStepsTotal = currentSteps.reduce(0, { $0 + $1 })
        let newCurrentStepsTotal = (currentStepsTotal - currentSteps[section] + steps)
        let overflow = min(0, totalSteps - newCurrentStepsTotal)
        currentSteps[section] = min(max(0, steps + overflow), maxSteps[section])
        layoutBar(bars[section], section: section)
        layoutIfNeeded()
    }
    
    public func advance(section: Int, by numberOfSteps: Int = 1) {
        setProgress(section: section, steps: currentSteps[section] + numberOfSteps)
    }

    public func resetProgress() {
        for section in 0..<bars.count {
            setProgress(section: section, steps: 0)
        }
    }

    
}







