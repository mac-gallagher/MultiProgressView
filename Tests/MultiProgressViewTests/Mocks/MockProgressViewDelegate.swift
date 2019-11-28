@testable import MultiProgressView

class MockMultiProgressViewDelegate: MultiProgressViewDelegate {
    
    var didTapSectionAtCalled: Bool = false
    var didTapSectionIndex: Int?
    
    func progressView(_ progressView: MultiProgressView, didTapSectionAt index: Int) {
        didTapSectionAtCalled = true
        didTapSectionIndex = index
    }
}
