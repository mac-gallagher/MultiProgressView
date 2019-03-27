//
//  TestableProgressViewSection.swift
//  MultiProgressView_Tests
//
//  Created by Mac Gallagher on 3/8/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

import MultiProgressView

class TestableProgressViewSection: ProgressViewSection {
    
    var setNeedsLayoutCalled: Bool = false
    override func setNeedsLayout() {
        setNeedsLayoutCalled = true
    }
    
    var sendSubviewToBackView: UIView?
    override func sendSubviewToBack(_ view: UIView) {
        sendSubviewToBackView = view
    }
}
