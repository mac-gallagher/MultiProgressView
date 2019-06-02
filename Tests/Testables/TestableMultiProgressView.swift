//
//  TestableMultiProgressView.swift
//  MultiProgressViewTests
//
//  Created by Mac Gallagher on 3/7/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

@testable import MultiProgressView

class TestableMultiProgressView: MultiProgressView {
    
    var setNeedsLayoutCalled: Bool = false
    override func setNeedsLayout() {
        setNeedsLayoutCalled = true
    }
    
    var layoutIfNeededCalled: Bool = false
    override func layoutIfNeeded() {
        layoutIfNeededCalled = true
    }
    
    var reloadDataCalled: Bool = false
    override func reloadData() {
        super.reloadData()
        reloadDataCalled = true
    }
    
    var updateCornerRadiusCalled: Bool = false
    override func updateCornerRadius() {
        super.updateCornerRadius()
        updateCornerRadiusCalled = true
    }
}
