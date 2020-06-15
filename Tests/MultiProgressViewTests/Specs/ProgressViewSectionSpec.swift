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
import Nimble
import Quick

// swiftlint:disable function_body_length implicitly_unwrapped_optional closure_body_length
class ProgressViewSectionSpec: QuickSpec {

  override func spec() {
    var mockLayoutProvider: MockLayoutProvider!
    var subject: TestableProgressViewSection!

    beforeEach {
      mockLayoutProvider = MockLayoutProvider()
      subject = TestableProgressViewSection(layoutProvider: mockLayoutProvider)
    }

    // MARK: - Initialization

    describe("When initializing a new section") {
      var section: ProgressViewSection!

      context("with the default initializer") {
        beforeEach {
          section = ProgressViewSection()
        }

        it("should have the correct default properties") {
          testDefaultProperties()
        }
      }

      context("with the required initializer") {
        beforeEach {
          // TODO: - Find a non-deprecated way to accomplish this
          let coder = NSKeyedUnarchiver(forReadingWith: Data())
          section = ProgressViewSection(coder: coder)
        }

        it("should have the correct default properties") {
          testDefaultProperties()
        }
      }

      func testDefaultProperties() {
        expect(section.titleLabel).toNot(beNil())
        expect(section.titleEdgeInsets) == .zero
        expect(section.titleAlignment) == .center
        expect(section.imageView).toNot(beNil())
        expect(section.backgroundColor) == .black
        expect(section.layer.masksToBounds) == true
        expect(section.subviews.contains(section.imageView)) == true
        expect(section.subviews.contains(section.titleLabel)) == true
        expect(section.gestureRecognizers?.count) == 1
      }
    }

    // MARK: - Variables

    // MARK: Title Insets

    describe("When setting titleInsets") {
      beforeEach {
        subject.titleEdgeInsets = UIEdgeInsets()
      }

      it("should trigger a layout update") {
        expect(subject.setNeedsLayoutCalled) == true
      }
    }

    // MARK: Title Alignment

    context("When setting titleAlignment") {
      beforeEach {
        subject.titleAlignment = .bottom
      }

      it("should trigger a layout update") {
        expect(subject.setNeedsLayoutCalled) == true
      }
    }

    // MARK: - Layout

    describe("When calling layoutSubviews") {
      let titleAlignment: AlignmentType = .topLeft
      let titleEdgeInsets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
      let labelConstraints = [NSLayoutConstraint]()
      let imageViewFrame = CGRect(x: 1, y: 2, width: 3, height: 4)

      beforeEach {
        mockLayoutProvider.testAnchorConstraints = labelConstraints
        mockLayoutProvider.testSectionImageViewFrame = imageViewFrame
        subject.titleAlignment = titleAlignment
        subject.titleEdgeInsets = titleEdgeInsets
        subject.layoutSubviews()
      }

      it("should correctly set the title label's constraints") {
        expect(subject.labelConstraints).to(be(labelConstraints))
        expect(mockLayoutProvider.anchorToSuperviewAlignment) == titleAlignment
        expect(mockLayoutProvider.anchorToSuperviewInsets) == titleEdgeInsets
      }

      it("should set the imageView's frame") {
        expect(subject.imageView.frame) == imageViewFrame
      }

      it("should send the the imageView to the back of the view hierarchy") {
        expect(subject.sendSubviewToBackView).to(be(subject.imageView))
      }
    }

    // MARK: - Tap Gesture Recognizer

    describe("When performing a tap on the section") {
      var mockDelegate: MockProgressViewSectionDelegate!

      beforeEach {
        mockDelegate = MockProgressViewSectionDelegate()
        subject.delegate = mockDelegate

        let tapGestureRecognizer = subject.tapGestureRecognizer as? TapGestureRecognizer
        tapGestureRecognizer?.performTap(withLocation: .zero)
      }

      it("should call the delegate's didTapSection method") {
        expect(mockDelegate.didTapSectionCalled) == true
      }
    }

    // MARK: - Main Methods

    // MARK: Set Title

    describe("When calling setTitle") {
      let title: String = "title"

      beforeEach {
        subject.setTitle(title)
      }

      it("should set the titleLabel's title") {
        expect(subject.titleLabel.text) == title
      }
    }

    // MARK: Set Attributed Title

    describe("When calling setAttributedTitle") {
      let attributedTitle = NSAttributedString(string: "title")

      beforeEach {
        subject.setAttributedTitle(attributedTitle)
      }

      it("should set the titleLabel's attributed title") {
        expect(subject.titleLabel.attributedText) == attributedTitle
      }
    }

    // MARK: Set Image

    describe("when calling setImage") {
      let image = UIImage()

      beforeEach {
        subject.setImage(image)
      }

      it("should set the imageView's image") {
        expect(subject.imageView.image) == image
      }
    }
  }
}
// swiftlint:enable function_body_length implicitly_unwrapped_optional closure_body_length
