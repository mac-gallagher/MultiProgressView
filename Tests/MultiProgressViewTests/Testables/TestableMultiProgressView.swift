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
