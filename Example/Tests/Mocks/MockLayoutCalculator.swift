//
//  MockLayoutCalculator.swift
//  MultiProgressView_Example
//
//  Created by Mac Gallagher on 3/6/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

@testable import MultiProgressView

class MockLayoutCalculator: LayoutCalculatable {
    
    func trackImageViewFrame(forProgressView progressView: MultiProgressView) -> CGRect {
        return .zero
    }
    
    func sectionImageViewFrame(forSection section: ProgressViewSection) -> CGRect {
        return .zero
    }
    
    func trackFrame(forProgressView progressView: MultiProgressView) -> CGRect {
        return .zero
    }
    
    func sectionFrame(forProgressView progressView: MultiProgressView, section: Int) -> CGRect {
        return .zero
    }
    
    func layoutTitleLabel(_ label: UILabel, withAlignment alignmentType: AlignmentType, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return []
    }
    
    func cornerRadius(forProgressView progressView: MultiProgressView) -> CGFloat {
        return 0
    }
    
    func trackCornerRadius(forProgressView progressview: MultiProgressView) -> CGFloat {
        return 0
    }
}
