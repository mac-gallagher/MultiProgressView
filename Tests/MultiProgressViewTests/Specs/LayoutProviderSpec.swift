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
class LayoutProviderSpec: QuickSpec {

  override func spec() {
    let numberOfSections: Int = 2
    let progressViewWidth: CGFloat = 200
    let progressViewHeight: CGFloat = 50

    var mockDataSource: MockMultiProgressViewDataSource!
    var progressView: TestableMultiProgressView!
    var subject: LayoutProvider!

    beforeEach {
      mockDataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)

      let progressViewFrame = CGRect(x: 0,
                                     y: 0,
                                     width: progressViewWidth,
                                     height: progressViewHeight)
      progressView = TestableMultiProgressView()
      progressView.frame = progressViewFrame
      progressView.dataSource = mockDataSource

      subject = LayoutProvider()
    }

    // MARK: - Track Frame

    describe("Track Frame") {
      context("When calling trackFrame") {
        let trackInset: CGFloat = 10

        beforeEach {
          progressView.trackInset = trackInset
        }

        context("and the line cap type is butt") {
          beforeEach {
            progressView.lineCap = .butt
          }

          it("should return the correct track frame") {
            let actualFrame = subject.trackFrame(progressView)
            let expectedFrame = CGRect(x: 0,
                                       y: trackInset,
                                       width: progressViewWidth,
                                       height: progressViewHeight - 2 * trackInset)
            expect(actualFrame) == expectedFrame
          }
        }

        context("and the line cap type is round") {
          beforeEach {
            progressView.lineCap = .round
          }

          it("should return the correct track frame") {
            let actualFrame = subject.trackFrame(progressView)
            let expectedFrame = CGRect(x: trackInset,
                                       y: trackInset,
                                       width: progressViewWidth - 2 * trackInset,
                                       height: progressViewHeight - 2 * trackInset)
            expect(actualFrame) == expectedFrame
          }
        }

        context("and the line cap type is square") {
          beforeEach {
            progressView.lineCap = .square
          }

          it("should return the correct track frame") {
            let actualFrame = subject.trackFrame(progressView)
            let expectedFrame = CGRect(x: trackInset,
                                       y: trackInset,
                                       width: progressViewWidth - 2 * trackInset,
                                       height: progressViewHeight - 2 * trackInset)
            expect(actualFrame) == expectedFrame
          }
        }
      }
    }

    // MARK: - Section Frame

    describe("Section Frame") {
      context("When calling sectionFrame") {
        let trackBounds = CGRect(x: 10, y: 20, width: 30, height: 40)
        let section: Int = 1

        beforeEach {
          progressView.track.bounds = trackBounds
        }

        context("and there is no progress on the section") {
          let progress: Float = 0

          beforeEach {
            progressView.setProgress(section: section, to: progress)
          }

          it("should return the correct frame with zero width") {
            let actualFrame = subject.sectionFrame(progressView, section: section)
            let expectedFrame = CGRect(x: trackBounds.origin.x,
                                       y: trackBounds.origin.y,
                                       width: 0,
                                       height: trackBounds.height)
            expect(actualFrame) == expectedFrame
          }
        }

        context("and there is progress on the section and the section before it has zero width") {
          let progress: Float = 0.5

          beforeEach {
            progressView.setProgress(section: section, to: progress)
          }

          it("should return the correct frame with the proper width") {
            let actualFrame = subject.sectionFrame(progressView, section: section)
            let expectedWidth = trackBounds.width * CGFloat(progress)
            let expectedFrame = CGRect(x: trackBounds.origin.x,
                                       y: trackBounds.origin.y,
                                       width: expectedWidth,
                                       height: trackBounds.height)
            expect(actualFrame) == expectedFrame
          }
        }

        context("and there is progress on the section and the section before it has a non-zero width") {
          let firstSectionFrame = CGRect(x: 0, y: 0, width: 30, height: 0)
          let progress: Float = 0.2

          beforeEach {
            let firstSection = progressView.progressViewSections.first(where: { $0.value == 0 })?.key
            firstSection?.frame = firstSectionFrame
            progressView.setProgress(section: section, to: progress)
          }

          it("should return the correct frame with the proper width and origin") {
            let actualFrame = subject.sectionFrame(progressView, section: section)

            let expectedOrigin = CGPoint(x: trackBounds.origin.x + firstSectionFrame.width,
                                         y: trackBounds.origin.y)
            let expectedSize = CGSize(width: trackBounds.width * CGFloat(progress),
                                      height: trackBounds.height)
            let expectedFrame = CGRect(origin: expectedOrigin, size: expectedSize)

            expect(actualFrame) == expectedFrame
          }
        }
      }
    }

    // MARK: - Track Image View Frame

    describe("When calling trackImageViewFrame") {
      let trackBounds = CGRect(x: 10, y: 20, width: 30, height: 40)

      beforeEach {
        progressView.track.bounds = trackBounds
      }

      it("should return the track's bounds") {
        let actualFrame = subject.trackImageViewFrame(progressView)
        expect(actualFrame) == trackBounds
      }
    }

    // MARK: - Section Image View Frame

    describe("When calling sectionImageViewFrame") {
      let sectionBounds = CGRect(x: 1, y: 2, width: 3, height: 4)
      let section = ProgressViewSection()

      beforeEach {
        section.bounds = sectionBounds
      }

      it("should return the section's bounds") {
        let actualFrame = subject.sectionImageViewFrame(section)
        expect(actualFrame) == sectionBounds
      }
    }

    // MARK: - Corner Radius

    describe("When calling cornerRadius") {
      context("and the line cap type is butt") {
        beforeEach {
          progressView.lineCap = .butt
        }

        it("should return zero") {
          let actualCornerRadius = subject.cornerRadius(progressView)
          expect(actualCornerRadius) == 0
        }
      }

      context("and the line cap type is square") {
        beforeEach {
          progressView.lineCap = .square
        }

        it("should return zero") {
          let actualCornerRadius = subject.cornerRadius(progressView)
          expect(actualCornerRadius) == 0
        }
      }

      context("and the line cap type is round") {
        beforeEach {
          progressView.lineCap = .round
        }

        context("and the corner radius is zero") {
          beforeEach {
            progressView.cornerRadius = 0
          }

          it("should return half the height of the progressView") {
            let actualCornerRadius = subject.cornerRadius(progressView)
            expect(actualCornerRadius) == progressViewHeight / 2
          }
        }

        context("and the corner radius is non-zero") {
          let cornerRadius: CGFloat = 5

          beforeEach {
            progressView.cornerRadius = cornerRadius
          }

          it("should return the progressView's corner radius") {
            let actualCornerRadius = subject.cornerRadius(progressView)
            expect(actualCornerRadius) == cornerRadius
          }
        }
      }
    }

    // MARK: - Track Corner Radius

    describe("When calling trackCornerRadius") {
      context("and the line cap type is butt") {
        beforeEach {
          progressView.lineCap = .butt
        }

        it("should return zero") {
          let actualCornerRadius = subject.trackCornerRadius(progressView)
          expect(actualCornerRadius) == 0
        }
      }

      context("and the line cap type is square") {
        beforeEach {
          progressView.lineCap = .square
        }

        it("should return zero") {
          let actualCornerRadius = subject.trackCornerRadius(progressView)
          expect(actualCornerRadius) == 0
        }
      }

      context("and the line cap type is round") {
        let trackBounds = CGRect(x: 0, y: 0, width: 0, height: 500)

        beforeEach {
          progressView.track.bounds = trackBounds
          progressView.lineCap = .round
        }

        context("and the corner radius is zero") {
          beforeEach {
            progressView.cornerRadius = 0
          }

          it("should return half the height of the track") {
            let actualCornerRadius = subject.trackCornerRadius(progressView)
            expect(actualCornerRadius) == trackBounds.height / 2
          }
        }

        context("and the corner radius is non-zero") {
          let cornerRadius: CGFloat = 5
          var cornerRadiusFactor: CGFloat!

          beforeEach {
            progressView.track.bounds = trackBounds
            progressView.cornerRadius = cornerRadius
            cornerRadiusFactor = cornerRadius / progressViewHeight
          }

          it("should return the correct scaled corner radius") {
            let actualCornerRadius = subject.trackCornerRadius(progressView)
            let expectedCornerRaduis = cornerRadiusFactor * trackBounds.height
            expect(actualCornerRadius) == expectedCornerRaduis
          }
        }
      }
    }

    // MARK: Layout Anchoring

    context("When calling anchorToSuperview") {
      let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
      var view: UIView!

      beforeEach {
        view = UIView()
      }

      context("and the view has no superview") {
        it("should return no constraints") {
          let actualConstraints = subject.anchorToSuperview(view,
                                                            withAlignment: .bottom,
                                                            insets: insets)
          expect(actualConstraints) == []
        }
      }

      context("and the view has a superview") {
        let superview = UIView()
        var topConstraint: NSLayoutConstraint!
        var leftConstraint: NSLayoutConstraint!
        var rightConstraint: NSLayoutConstraint!
        var bottomConstraint: NSLayoutConstraint!
        var centerXConstraint: NSLayoutConstraint!
        var centerYConstraint: NSLayoutConstraint!

        beforeEach {
          superview.addSubview(view)

          topConstraint = view.topAnchor.constraint(equalTo: superview.topAnchor,
                                                    constant: insets.top)
          leftConstraint = view.leftAnchor.constraint(equalTo: superview.leftAnchor,
                                                      constant: insets.left)
          rightConstraint = view.rightAnchor.constraint(equalTo: superview.rightAnchor,
                                                        constant: -insets.right)
          bottomConstraint = view.bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                                          constant: -insets.bottom)
          centerXConstraint = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor,
                                                            constant: insets.left - insets.right)
          centerYConstraint = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor,
                                                            constant: insets.top - insets.bottom)
        }

        context("and the alignment is equal to top") {
          it("should return the correct layout constraints") {
            let actualConstraints = subject.anchorToSuperview(view,
                                                              withAlignment: .top,
                                                              insets: insets)
            expect(actualConstraints.count) == 2
            expect(actualConstraints.contains(centerXConstraint)) == true
            expect(actualConstraints.contains(topConstraint)) == true
          }
        }

        context("and the alignment is equal to topLeft") {
          it("should return the correct layout constraints") {
            let actualConstraints = subject.anchorToSuperview(view,
                                                              withAlignment: .topLeft,
                                                              insets: insets)
            expect(actualConstraints.count) == 2
            expect(actualConstraints.contains(topConstraint)) == true
            expect(actualConstraints.contains(leftConstraint)) == true
          }
        }

        context("and the alignment is equal to left") {
          it("should return the correct layout constraints") {
            let actualConstraints = subject.anchorToSuperview(view,
                                                              withAlignment: .left,
                                                              insets: insets)
            expect(actualConstraints.count) == 2
            expect(actualConstraints.contains(centerYConstraint)) == true
            expect(actualConstraints.contains(leftConstraint)) == true
          }
        }

        context("and the alignment is equal to bottomLeft") {
          it("should return the correct layout constraints") {
            let actualConstraints = subject.anchorToSuperview(view,
                                                              withAlignment: .bottomLeft,
                                                              insets: insets)
            expect(actualConstraints.count) == 2
            expect(actualConstraints.contains(bottomConstraint)) == true
            expect(actualConstraints.contains(leftConstraint)) == true
          }
        }

        context("and the alignment is equal to bottom") {
          it("should return the correct layout constraints") {
            let actualConstraints = subject.anchorToSuperview(view,
                                                              withAlignment: .bottom,
                                                              insets: insets)
            expect(actualConstraints.count) == 2
            expect(actualConstraints.contains(centerXConstraint)) == true
            expect(actualConstraints.contains(bottomConstraint)) == true
          }
        }

        context("and the alignment is equal to bottomRight") {
          it("should return the correct layout constraints") {
            let actualConstraints = subject.anchorToSuperview(view,
                                                              withAlignment: .bottomRight,
                                                              insets: insets)
            expect(actualConstraints.count) == 2
            expect(actualConstraints.contains(bottomConstraint)) == true
            expect(actualConstraints.contains(rightConstraint)) == true
          }
        }

        context("and the alignment is equal to right") {
          it("should return the correct layout constraints") {
            let actualConstraints = subject.anchorToSuperview(view,
                                                              withAlignment: .right,
                                                              insets: insets)
            expect(actualConstraints.count) == 2
            expect(actualConstraints.contains(centerYConstraint)) == true
            expect(actualConstraints.contains(rightConstraint)) == true
          }
        }

        context("and the alignment is equal to topRight") {
          it("should return the correct layout constraints") {
            let actualConstraints = subject.anchorToSuperview(view,
                                                              withAlignment: .topRight,
                                                              insets: insets)
            expect(actualConstraints.count) == 2
            expect(actualConstraints.contains(rightConstraint)) == true
            expect(actualConstraints.contains(topConstraint)) == true
          }
        }

        context("and the alignment is equal to center") {
          it("should return the correct layout constraints") {
            let actualConstraints = subject.anchorToSuperview(view,
                                                              withAlignment: .center,
                                                              insets: insets)
            expect(actualConstraints.count) == 2
            expect(actualConstraints.contains(centerXConstraint)) == true
            expect(actualConstraints.contains(centerYConstraint)) == true
          }
        }
      }
    }
  }
}
// swiftlint:enable function_body_length implicitly_unwrapped_optional
