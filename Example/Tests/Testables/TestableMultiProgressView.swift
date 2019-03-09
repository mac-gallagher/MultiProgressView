//
//  TestableMultiProgressView.swift
//  MultiProgressView_Tests
//
//  Created by Mac Gallagher on 3/7/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

@testable import MultiProgressView

class TestableMultiProgressView: MultiProgressView {
    
    var setNeedsLayoutCalled: Bool = false
    override func setNeedsLayout() {
        super.setNeedsLayout()
        setNeedsLayoutCalled = true
    }
    
    var layoutIfNeededCalled: Bool = false
    override func layoutIfNeeded() {
        layoutIfNeededCalled = true
    }
    
    var layoutSubviewsCalled: Bool = false
    override func layoutSubviews() {
        layoutSubviewsCalled = true
    }
    
    var reloadDataCalled: Bool = false
    override func reloadData() {
        super.reloadData()
        reloadDataCalled = true
    }
}
