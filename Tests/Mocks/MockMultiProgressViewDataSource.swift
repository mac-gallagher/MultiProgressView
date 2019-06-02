//
//  MockMultiProgressViewDataSource.swift
//  MultiProgressViewTests
//
//  Created by Mac Gallagher on 3/1/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

import MultiProgressView

class MockMultiProgressViewDataSource: MultiProgressViewDataSource {
    var numberOfSections: Int
    
    init(numberOfSections: Int = 0) {
        self.numberOfSections = numberOfSections
    }
    
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        return numberOfSections
    }
    
    lazy var progressViewSections: [ProgressViewSection] = {
        var sections = [ProgressViewSection]()
        for index in 0..<numberOfSections {
            sections.append(ProgressViewSection())
        }
        return sections
    }()
    
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        return progressViewSections[section]
    }
}
