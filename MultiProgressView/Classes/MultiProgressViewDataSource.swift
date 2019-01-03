//
//  MGSegmentedProgressBarDataSource.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

public protocol MultiProgressViewDataSource {
    func numberOfUnits(in progressBar: MultiProgressView) -> Int
    func numberOfSections(in progressBar: MultiProgressView) -> Int
    func progressBar(_ progressBar: MultiProgressView, barForSection section: Int) -> ProgressBarSection
}
