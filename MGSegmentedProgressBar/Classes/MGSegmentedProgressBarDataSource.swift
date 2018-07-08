//
//  MGSegmentedProgressBarDataSource.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 6/15/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Foundation

public protocol MGSegmentedProgressBarDataSource {
    
    func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> MGBarView
   
    func progressBar(_ progressBar: MGSegmentedProgressBar, numberOfStepsInSection section: Int) -> Int
    
}
