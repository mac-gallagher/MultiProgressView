@testable import MultiProgressView

class MockProgressViewSectionDelegate: ProgressViewSectionDelegate {
    
    var didTapSectionCalled: Bool = false
    func didTapSection(_ section: ProgressViewSection) {
        didTapSectionCalled = true
    }
}
