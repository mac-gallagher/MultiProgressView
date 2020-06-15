///
/// MIT License
///
/// Copyright (c) 2020 Mac Gallagher
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
///

@testable import MultiProgressView

class MockLayoutProvider: LayoutProvidable {

  var testTrackFrame: CGRect = .zero
  func trackFrame(_ progressView: MultiProgressView) -> CGRect {
    return testTrackFrame
  }

  var testTrackImageViewFrame: CGRect = .zero
  func trackImageViewFrame(_ progressView: MultiProgressView) -> CGRect {
    return testTrackImageViewFrame
  }

  var testCornerRadius: CGFloat = 0.0
  func cornerRadius(_ progressView: MultiProgressView) -> CGFloat {
    return testCornerRadius
  }

  var testTrackCornerRadius: CGFloat = 0.0
  func trackCornerRadius(_ progressView: MultiProgressView) -> CGFloat {
    return testTrackCornerRadius
  }

  var testSectionFrame: CGRect = .zero
  func sectionFrame(_ progressView: MultiProgressView, section: Int) -> CGRect {
    return testSectionFrame
  }

  var testSectionImageViewFrame: CGRect = .zero
  func sectionImageViewFrame(_ section: ProgressViewSection) -> CGRect {
    return testSectionImageViewFrame
  }

  var testAnchorConstraints: [NSLayoutConstraint] = []
  var anchorToSuperviewAlignment: AlignmentType?
  var anchorToSuperviewInsets: UIEdgeInsets?

  func anchorToSuperview(_ view: UIView,
                         withAlignment alignment: AlignmentType,
                         insets: UIEdgeInsets) -> [NSLayoutConstraint] {
    anchorToSuperviewAlignment = alignment
    anchorToSuperviewInsets = insets
    return testAnchorConstraints
  }
}
