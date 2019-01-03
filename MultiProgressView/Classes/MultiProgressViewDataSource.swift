//
//  MGSegmentedProgressBarDataSource.swift
//  MultiProgressView
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

public protocol MultiProgressViewDataSource {
    func numberOfUnits(in progressView: MultiProgressView) -> Int
    func numberOfSections(in progressView: MultiProgressView) -> Int
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection
}
