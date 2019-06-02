//
//  MockLayoutCalculator.swift
//  MultiProgressViewTests
//
//  Created by Mac Gallagher on 3/6/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

@testable import MultiProgressView

class MockLayoutCalculator: LayoutCalculatable {
    
    var testTrackImageViewFrame: CGRect = CGRect()
    func trackImageViewFrame(forProgressView progressView: MultiProgressView) -> CGRect {
        return testTrackImageViewFrame
    }
    
    var testSectionImageViewFrame: CGRect = CGRect()
    func sectionImageViewFrame(forSection section: ProgressViewSection) -> CGRect {
        return testSectionImageViewFrame
    }
    
    var testTrackFrame: CGRect = CGRect()
    func trackFrame(forProgressView progressView: MultiProgressView) -> CGRect {
        return testTrackFrame
    }
    
    var testSectionFrame: CGRect = CGRect()
    func sectionFrame(forProgressView progressView: MultiProgressView, section: Int) -> CGRect {
        return testSectionFrame
    }
    
    var testCornerRadius: CGFloat = CGFloat()
    func cornerRadius(forProgressView progressView: MultiProgressView) -> CGFloat {
        return testCornerRadius
    }
    
    var testTrackCornerRadius: CGFloat = CGFloat()
    func trackCornerRadius(forProgressView progressview: MultiProgressView) -> CGFloat {
        return testTrackCornerRadius
    }
    
    var testAnchorConstraints: [NSLayoutConstraint] = []
    var anchorToSuperviewAlignment: AlignmentType?
    var anchorToSuperviewInsets: UIEdgeInsets?
    
    func anchorToSuperview(_ view: UIView, withAlignment alignment: AlignmentType, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        anchorToSuperviewAlignment = alignment
        anchorToSuperviewInsets = insets
        return testAnchorConstraints
    }
}
