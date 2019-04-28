//
//  LanguageExampleProgressView.swift
//  MultiProgressViewExample
//
//  Created by Mac Gallagher on 4/26/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

import UIKit
import MultiProgressView

@IBDesignable
class LanguageExampleProgressView: MultiProgressView {
    
    @IBInspectable var language: Int = 0 {
        didSet {
            titleLabel.text = CodingLanguage(rawValue: language)?.description
        }
    }
    
    @IBInspectable var percentage: Int = 0 {
        didSet {
            percentageLabel.text = "\(percentage)%"
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        setupLabels()
        lineCap = .round
        titleLabel.isHidden = true
    }
    
    private func setupLabels() {
        addSubview(titleLabel)
        titleLabel.anchor(left: leftAnchor, paddingLeft: 8)
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(percentageLabel)
        percentageLabel.anchor(right: rightAnchor, paddingRight: 8)
        percentageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func shouldHideTitle(_ hide: Bool) {
        titleLabel.isHidden = hide
    }
}
