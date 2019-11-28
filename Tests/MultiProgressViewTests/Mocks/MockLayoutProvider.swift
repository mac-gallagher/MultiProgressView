@testable import MultiProgressView

struct MockLayoutProvider: LayoutProvidable {
    
    static var testTrackFrame: CGRect = .zero
    static var trackFrame: (MultiProgressView) -> CGRect {
        return { _ in
            return testTrackFrame
        }
    }
    
    static var testTrackImageViewFrame: CGRect = .zero
    static var trackImageViewFrame: (MultiProgressView) -> CGRect {
        return { _ in
            return testTrackImageViewFrame
        }
    }
    
    static var testSectionImageViewFrame: CGRect = .zero
    static var sectionImageViewFrame: (ProgressViewSection) -> CGRect {
        return { _ in
            return testSectionImageViewFrame
        }
    }
    
    static var testSectionFrame: CGRect = .zero
    static var sectionFrame: (MultiProgressView, Int) -> CGRect {
        return { _, _ in
            return testSectionFrame
        }
    }
    
    static var testCornerRadius: CGFloat = 0.0
    static var cornerRadius: (MultiProgressView) -> CGFloat {
        return { _ in
            return testCornerRadius
        }
    }
    
    static var testTrackCornerRadius: CGFloat = 0.0
    static var trackCornerRadius: (MultiProgressView) -> CGFloat {
        return { _ in
            return testTrackCornerRadius
        }
    }
    
    static var testAnchorConstraints: [NSLayoutConstraint] = []
    static var anchorToSuperviewAlignment: AlignmentType?
    static var anchorToSuperviewInsets: UIEdgeInsets?
    
    static func anchorToSuperview(_ view: UIView,
                                  withAlignment alignment: AlignmentType,
                                  insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        anchorToSuperviewAlignment = alignment
        anchorToSuperviewInsets = insets
        return testAnchorConstraints
    }
    
    // MARK: - Test Helpers
    
    static func reset() {
        testTrackFrame = .zero
        testTrackImageViewFrame = .zero
        testSectionImageViewFrame = .zero
        testSectionFrame = .zero
        testCornerRadius = 0.0
        testTrackCornerRadius = 0.0
        
        testAnchorConstraints = []
        anchorToSuperviewAlignment = nil
        anchorToSuperviewInsets = nil
    }
}
