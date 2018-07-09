//
//  MGSegmentedProgressBarDataSource.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Foundation

public protocol MGSegmentedProgressBarDataSource {
    
    //MARK: - Required
    func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int
    func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> MGBarView
    func progressBar(_ progressBar: MGSegmentedProgressBar, numberOfStepsInSection section: Int) -> Int

    //MARK: - Optional
    func progressBar(_ progressBar: MGSegmentedProgressBar, attributedTitleForSection section: Int) -> NSAttributedString?
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleForSection section: Int) -> String?
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleInsetsForSection section: Int) -> UIEdgeInsets
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleAlignmentForSection section: Int) -> MGLabelAlignment

}

public extension MGSegmentedProgressBarDataSource {
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, attributedTitleForSection section: Int) -> NSAttributedString? {
        return nil
    }
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleForSection section: Int) -> String? {
        return nil
    }
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleInsetsForSection section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleAlignmentForSection section: Int) -> MGLabelAlignment {
        return .center
    }
    
}
