@testable import MultiProgressView

class TestableProgressViewSection: ProgressViewSection {

  override var tapGestureRecognizer: UITapGestureRecognizer {
    return tapRecognizer
  }

  private lazy var tapRecognizer = TestableTapGestureRecognizer(target: self,
                                                                action: #selector(didTap))

  var setNeedsLayoutCalled: Bool = false
  override func setNeedsLayout() {
    setNeedsLayoutCalled = true
  }

  var sendSubviewToBackView: UIView?
  override func sendSubviewToBack(_ view: UIView) {
    sendSubviewToBackView = view
  }
}
