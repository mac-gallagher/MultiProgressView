//
//  MockMultiProgressViewDataSource.swift
//  MultiProgressView_Example
//
//  Created by Mac Gallagher on 3/1/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

import MultiProgressView

class MockMultiProgressViewDataSource: MultiProgressViewDataSource {
    var numberOfSectionsCalled: Bool = false
    var viewForSectionCalledCount: Int = 0
    
    private var numberOfSections: Int
    
    init(numberOfSections: Int = 0) {
        self.numberOfSections = numberOfSections
    }
    
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        numberOfSectionsCalled = true
        return numberOfSections
    }
    
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        viewForSectionCalledCount += 1
        return ProgressViewSection()
    }
}
