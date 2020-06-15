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
