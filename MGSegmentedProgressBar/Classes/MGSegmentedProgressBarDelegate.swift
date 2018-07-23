//
//  MGSegmentedProgressBarDelegate.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 7/22/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Foundation

public protocol MGSegmentedProgressBarDelegate {
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleInsetsForSection section: Int) -> UIEdgeInsets
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleAlignmentForSection section: Int) -> MGLabelAlignment
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleAlwaysVisibleForSection section: Int) -> Bool
}

public extension MGSegmentedProgressBarDelegate {
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleInsetsForSection section: Int) -> UIEdgeInsets { return .zero }
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleAlignmentForSection section: Int) -> MGLabelAlignment { return .center }
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleAlwaysVisibleForSection section: Int) -> Bool { return false }
}
