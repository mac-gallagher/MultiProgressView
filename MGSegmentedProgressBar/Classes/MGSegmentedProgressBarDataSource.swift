//
//  MGSegmentedProgressBarDataSource.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

public protocol MGSegmentedProgressBarDataSource {
    func numberOfSteps(in progressBar: MGSegmentedProgressBar) -> Int
    func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int
    func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> ProgressBarSection
}
