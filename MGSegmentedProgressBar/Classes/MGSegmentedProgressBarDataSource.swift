//
//  MGSegmentedProgressBarDataSource.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Foundation

public protocol MGSegmentedProgressBarDataSource {
    
    func numberOfSteps(in progressBar: MGSegmentedProgressBar) -> Int
    func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int
    func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> MGBarView
    func progressBar(_ progressBar: MGSegmentedProgressBar, maximumNumberOfStepsForSection section: Int) -> Int
    func progressBar(_ progressBar: MGSegmentedProgressBar, attributedTitleForSection section: Int) -> NSAttributedString?
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleForSection section: Int) -> String?
}

public extension MGSegmentedProgressBarDataSource {
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, maximumNumberOfStepsForSection section: Int) -> Int { return Int.max }
    func progressBar(_ progressBar: MGSegmentedProgressBar, attributedTitleForSection section: Int) -> NSAttributedString? { return nil }
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleForSection section: Int) -> String? { return nil }
}
