//
//  MGSegmentedProgressBar.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

// MARK: - Line Cap Enum
public enum MGLineCap {
    case round, square
}

open class MGSegmentedProgressBar: UIView {
    
    //MARK: - Variables
    
    //MARK: Public
    
    public var dataSource: MGSegmentedProgressBarDataSource? {
        didSet {
            reloadData()
        }
    }
    
    override open var layer: CALayer {
        return backgroundView.layer
    }
    
    open override var backgroundColor: UIColor? {
        didSet {
            backgroundView.backgroundColor = backgroundColor
            super.backgroundColor = .clear
        }
    }
    
    public var titleLabel: UILabel?
    
    public var labelEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var backgroundLabelHorizontalAlignment: MGHorizontalAlignment = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var backgroundLabelVerticalAlignment: MGVerticalAlignment = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    public let trackView: UIView = {
        let track = UIView()
        track.clipsToBounds = true
        return track
    }()
    
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
    
    public var lineCap: MGLineCap = .round {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //MARK: Private 
    
    private let backgroundView = UIView()
    
    private var bars: [MGBarView] = []
    
    private var currentStepForSection: [Int: Int] = [:]
    
    private var numberOfStepsForSection: [Int: Int] = [:]
    
    private var totalSteps = 0
    
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
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backgroundView.addSubview(trackView)
    }
    
    //MARK: - Layout

    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutTrackView()
        layoutBackgroundLabel()
        for index in 0..<bars.count {
            layoutBar(section: index)
        }
    }
    
    private var trackViewConstriants = [NSLayoutConstraint]()
    
    private func layoutTrackView() {
        trackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.deactivate(trackViewConstriants)
        trackViewConstriants = []
        trackViewConstriants.append(trackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: trackInset))
        trackViewConstriants.append(trackView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -trackInset))
        trackViewConstriants.append(trackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -trackInset))
        trackViewConstriants.append(trackView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: trackInset))
        NSLayoutConstraint.activate(trackViewConstriants)
    }
    
    private var backgroundLabelConstraints = [NSLayoutConstraint]()
    
    private func layoutBackgroundLabel() {
        guard let label = titleLabel else { return }
        
        label.layoutMargins = UIEdgeInsets(top: -labelEdgeInsets.top, left: -labelEdgeInsets.left, bottom: -labelEdgeInsets.bottom, right: -labelEdgeInsets.right)
        
        NSLayoutConstraint.deactivate(backgroundLabelConstraints)
        label.translatesAutoresizingMaskIntoConstraints = false
        backgroundLabelConstraints = []
        
        switch backgroundLabelHorizontalAlignment {
        case .left:
            backgroundLabelConstraints.append(label.layoutMarginsGuide.leftAnchor.constraint(equalTo: leftAnchor))
            label.textAlignment = .left
        case .center:
            backgroundLabelConstraints.append(label.layoutMarginsGuide.centerXAnchor.constraint(equalTo: centerXAnchor))
            label.textAlignment = .center
        case .right:
            backgroundLabelConstraints.append(label.layoutMarginsGuide.rightAnchor.constraint(equalTo: rightAnchor))
            label.textAlignment = .right
        }
        
        switch backgroundLabelVerticalAlignment {
        case .top:
            backgroundLabelConstraints.append(label.layoutMarginsGuide.topAnchor.constraint(equalTo: topAnchor))
        case .center:
            backgroundLabelConstraints.append(label.layoutMarginsGuide.centerYAnchor.constraint(equalTo: centerYAnchor))
        case .bottom:
            backgroundLabelConstraints.append(label.layoutMarginsGuide.bottomAnchor.constraint(equalTo: bottomAnchor))
        }
        
        NSLayoutConstraint.activate(backgroundLabelConstraints)
    }
    
    private var barConstraintsForSection: [Int: [NSLayoutConstraint]] = [:]
    
    private func layoutBar(section: Int) {
        let bar = bars[section]
        
        if barConstraintsForSection[section] != nil {
            NSLayoutConstraint.deactivate(barConstraintsForSection[section]!)
        }
        barConstraintsForSection[section] = []
        bar.translatesAutoresizingMaskIntoConstraints = false
        
        barConstraintsForSection[section]?.append(bar.topAnchor.constraint(equalTo: trackView.topAnchor))
        barConstraintsForSection[section]?.append(bar.bottomAnchor.constraint(equalTo: trackView.bottomAnchor))
        
        if section == 0 {
            barConstraintsForSection[section]?.append(bar.leftAnchor.constraint(equalTo: trackView.leftAnchor))
        } else {
            barConstraintsForSection[section]?.append(bar.leftAnchor.constraint(equalTo: bars[section - 1].rightAnchor))
        }
        
        if let steps = currentStepForSection[section], totalSteps != 0 {
            let widthMultiplier = CGFloat(steps) / CGFloat(totalSteps)
            barConstraintsForSection[section]?.append(bar.widthAnchor.constraint(equalTo: trackView.widthAnchor, multiplier: widthMultiplier, constant: 0))
        }
        
        NSLayoutConstraint.activate(barConstraintsForSection[section]!)
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        switch lineCap {
        case .round:
            layer.cornerRadius = bounds.height / 2
            trackView.layer.cornerRadius = trackView.bounds.height / 2
        case .square:
            layer.cornerRadius = 0
            trackView.layer.cornerRadius = 0
        }
    }
    
    //MARK: - Setters/Getters
    
    open func setTitle(_ title: String?, forSection section: Int) {
        if section < 0 || section >= bars.count { return }
        bars[section].setTitle(title)
    }
    
    open func setAttributedTitle(_ title: NSAttributedString?, forSection section: Int) {
        if section < 0 || section >= bars.count { return }
        bars[section].setAttributedTitle(title)
    }
    
    open func setBackgroundTitle(_ title: String?) {
        if titleLabel == nil {
            titleLabel?.removeFromSuperview()
            titleLabel = UILabel()
            trackView.insertSubview(titleLabel!, at: 0)
        }
        titleLabel?.text = title
        layoutBackgroundLabel()
    }
    
    open func setShadow(radius: CGFloat, opacity: Float, offset: CGSize = .zero, color: UIColor = UIColor.black) {
        super.layer.shadowRadius = radius
        super.layer.shadowOpacity = opacity
        super.layer.shadowOffset = offset
        super.layer.shadowColor = color.cgColor
    }
    
    //MARK: - Main Methods
    
    open func setProgress(section: Int, steps: Int) {
        if section < 0 || section >= bars.count { return }
        if steps <= 0 {
            currentStepForSection[section] = 0
        } else {
            currentStepForSection[section] = min(steps, numberOfStepsForSection[section] ?? 0)
        }
        layoutBar(section: section)
    }
    
    open func advance(section: Int, by numberOfSteps: Int = 1) {
        setProgress(section: section, steps: (currentStepForSection[section] ?? 0) + numberOfSteps)
    }

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
            trackView.addSubview(bar)
            bars.append(bar)
            currentStepForSection[section] = 0
            let steps = dataSource.progressBar(self, numberOfStepsInSection: section)
            numberOfStepsForSection[section] = steps
            totalSteps += steps
        }
        setNeedsLayout()
    }
    
}




